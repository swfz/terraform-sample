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
    INFO: 'good',
    WARNING: 'warning',
    CRITICAL: 'danger',
  }

  const color = colors[params.severity];

  await webhook.send({
    blocks: [
      {
        type: "section",
        text: {
          type: "mrkdwn",
          text: `Logged... ${params.logName}`
        }
      }
    ],
    attachments: [
      {
        color: `${color}`,
        fields: [
          {
            title: `Labels: ${JSON.stringify(params.resource.labels)}`,
            value: `\`\`\`${params.textPayload}\`\`\``
          }
        ]
      }
    ]
  });
};
