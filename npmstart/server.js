'use-strict'

const port = 3007;

const serve = require('koa-static');
const koa   = require('koa');
const router = require('koa-router')();
const parse = require('co-body');
const app   = koa();


// request body is not always parsed (e.g., xml requests)
function *getRequestBody(next) {
  var len = this.request.headers['content-length'];
  console.error('content length: ', len, this.request.type)
  this.request.type = 'application/text'
  var body = yield parse.text(this.request.req);
  this.request.textbody = body;
  yield next;
  };

app
  // .use(getRequestBody)
  .use(router.routes())
  .use(router.allowedMethods())
  .use(serve('www', { maxage: 60*60 }))
  ;

router.get('/mytest', function *(next) {
  this.response.type = 'text/json';
  this.body = {a: 3};
});

app.listen(port);
console.log('listening at http://localhost:' + port + '/');

