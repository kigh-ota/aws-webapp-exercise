import { Express } from 'express';
import express = require('express');
import createError from 'http-errors';

export default function setupEndpoints(app: Express) {
  app.get('/', (req, res) => {
    res.render('index');
  });

  // catch 404 and forward to error handler
  app.use(function (req, res, next) {
    next(createError(404));
  });

  // error handler
  app.use(function (err, req, res) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
  } as express.ErrorRequestHandler);
}
