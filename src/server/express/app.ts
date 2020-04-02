import express, { Express } from 'express';
import path from 'path';
import logger from 'morgan';

function initializeExpress(): Express {
  const app = express();

  // view engine setup
  app.set(
    'views',
    path.join(__dirname, '..', '..', '..', 'src', 'static', 'express', 'views')
  );
  app.set('view engine', 'pug');

  app.use(logger('dev'));
  // app.use(express.json());
  app.use(express.urlencoded({ extended: false }));
  app.use(express.static(path.join(__dirname, '..', '..', '..', 'public')));

  return app;
}

// async function main(app: Express) {
// }

const app = initializeExpress();
// main(app);

module.exports = app;
