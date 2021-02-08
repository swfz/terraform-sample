// Imports the Google Cloud Tasks library.
const {CloudTasksClient} = require('@google-cloud/tasks');

// Instantiates a client.
const client = new CloudTasksClient();

async function createHttpTask() {
  // TODO(developer): Uncomment these lines and replace with your values.
  const project = 'sample-project-111111';
  const queue = 'sample-queue';
  const location = 'asia-northeast1';
  const url = 'https://asia-northeast1-sample-project-111111.cloudfunctions.net/helloWorld/';
  const serviceAccountEmail = 'sample-project@sample-project-111111.iam.gserviceaccount.com'
  const payload = 'Hello, World!';
  const inSeconds = 10;

  // Construct the fully qualified queue name.
  const parent = client.queuePath(project, location, queue);

  const task = {
    httpRequest: {
      httpMethod: 'POST',
      url: url,
      oidcToken: {
        serviceAccountEmail: serviceAccountEmail
      },
      headers: { 'Content-Type': 'application/json' }
    },
  };

  if (payload) {
    task.httpRequest.body = Buffer.from(payload).toString('base64');
  }

  if (inSeconds) {
    // The time when the task is scheduled to be attempted.
    task.scheduleTime = {
      seconds: inSeconds + Date.now() / 1000,
    };
  }

  // Send create task request.
  console.log('Sending task:');
  console.log(task);
  const request = {parent, task};
  const [response] = await client.createTask(request);
  console.log(`Created task ${response.name}`);
}
createHttpTask();

