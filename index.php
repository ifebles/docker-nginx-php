<!DOCTYPE html>
<html>
  <head>
    <title>Welcome to nginx!</title>
    <style>
      body {
        font-family: Tahoma, Verdana, Arial, sans-serif;
      }

      div {
        margin: 0 auto;
      }
    </style>
  </head>

  <body>
    <div style="max-width: 35em">
      <h1>Welcome to nginx!</h1>
      <p>
        If you see this page, the nginx web server is successfully installed and
        working. Further configuration is required.
      </p>

      <p>
        For online documentation and support please refer to
        <a href="http://nginx.org/">nginx.org</a>.<br/>
        Commercial support is available at
        <a href="http://nginx.com/">nginx.com</a>.
      </p>

      <p><em>Thank you for using nginx.</em></p>
    </div>

    <br />

    <div style="max-width: 55em">
      <h3>PHP validation:</h3>
      <pre style="white-space: pre-wrap;overflow-wrap: break-word;">
        <?php print_r($_SERVER) ?>
      </pre>
    </div>

    <br />

    <div>
      <h3 class="center">PHP info</h3>
      <?php phpinfo() ?>
    </div>
  </body>
</html>
