/**
 * Responds to any HTTP request.
 *
 * @param {!express:Request} req HTTP request context.
 * @param {!express:Response} res HTTP response context.
 */

const puppeteer = require('puppeteer');

exports.sampleFunction = async (req, res) => {
  const browser = await puppeteer.launch({args: ['--no-sandbox', '--disable-setuid-sandbox']});  const page = await browser.newPage();

  const requestUrl = 'https://example.com';
  await page.goto(requestUrl);
  await page.waitFor(2000);
  const content = await page.$eval('h1', h1 => h1.textContent);

  console.log(content);

  await res.status(200).send(JSON.stringify({content}));
};

