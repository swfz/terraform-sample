/**
 * Responds to any HTTP request.
 *
 * @param {!express:Request} req HTTP request context.
 * @param {!express:Response} res HTTP response context.
 */
exports.helloWorld = async (req, res) => {
  // let message = req.query.message || req.body.message || 'Hello World!';
  const error = 'Server Error!!!';
  console.log(new Date());
  function sleep(time) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve();
      }, time)
    });
  }

  await sleep(2000);
  console.log('sleeped');
  res.status(500).send(error);
};

