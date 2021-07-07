/**
 * Triggered from a message on a Cloud Pub/Sub topic.
 *
 * @param {!Object} event Event payload.
 * @param {!Object} context Metadata for the event.
 */

const { IncomingWebhook } = require('@slack/webhook');

exports.slackNotification = async (event, context) => {
  const data = Buffer.from(event.data, 'base64').toString();
  const params = JSON.parse(data);

  const url = process.env.SLACK_WEBHOOK_URL;
  const webhook = new IncomingWebhook(url);

  const colors = {
    INFO: '#2EB886',
    WARNING: '#DAA038',
    CRITICAL: '#A30100',
  }
  const color = colors[params.severity];

  await webhook.send({
    attachments: [
      {
        color: color,
        blocks: [
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: `*LogName: ${params.logName}*`
            }
          },
          {
            type: "divider"
          },
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: `*Labels: ${JSON.stringify(params.resource.labels)}*`,
            }
          },
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: `\`\`\`${params.textPayload}\`\`\``
            }
          }
        ]
      }
    ]
  });
};
