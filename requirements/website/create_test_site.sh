#!/usr/bin/env bash

WEBROOT="/var/www"
HTMLROOT="${WEBROOT}/html"
LOGDIR="${WEBROOT}/logs"
CGIROOT="${WEBROOT}/cgi-bin"

mkdir -p ${HTMLROOT}/images \
         ${HTMLROOT}/css \
         ${HTMLROOT}/js \
         ${HTMLROOT}/error \
         ${HTMLROOT}/directory \
         ${HTMLROOT}/uploads \
         ${HTMLROOT}/new-page \
         ${HTMLROOT}/about \
         ${HTMLROOT}/contact \
         ${HTMLROOT}/empty-directory \
         ${HTMLROOT}/protected-resource \
         ${HTMLROOT}/store \
         ${HTMLROOT}/cgi-test \
         ${CGIROOT} \
         ${LOGDIR}

chown -R www-data:www-data ${WEBROOT}
chmod -R 755 ${WEBROOT}

cat > ${HTMLROOT}/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Webserver Test Page</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <img src="images/logo.png" alt="Logo" class="logo">
            <h1>Webserver Test Page</h1>
        </header>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/directory/">Directory Listing</a></li>
                <li><a href="/uploads/">Uploads</a></li>
                <li><a href="/old-page/">Redirect Test</a></li>
                <li><a href="/about">About</a></li>
                <li><a href="/contact">Contact</a></li>
                <li><a href="/protected-resource">Protected Resource</a></li>
                <li><a href="/cgi-test">CGI Test</a></li>
            </ul>
        </nav>
        <main>
            <!-- Empty main content -->
        </main>
        <footer>
            <p>&copy; 2024 Webserver Test Page</p>
        </footer>
    </div>

    <script src="js/main.js"></script>
</body>
</html>
EOF

cat > ${HTMLROOT}/protected-resource/data.json << 'EOF'
{
  "id": 1,
  "name": "Test Resource",
  "description": "This is a protected JSON resource for testing HTTP methods",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z",
  "properties": {
    "isActive": true,
    "priority": "high",
    "tags": ["test", "api", "json"]
  }
}
EOF
chmod 644 ${HTMLROOT}/protected-resource/data.json
chown www-data:www-data ${HTMLROOT}/protected-resource/data.json

cat > ${HTMLROOT}/css/protected-resource.css << 'EOF'
.test-section {
    margin-bottom: 30px;
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
}
.result-area {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 4px;
    margin-top: 15px;
    min-height: 100px;
    max-height: 300px;
    overflow: auto;
    font-family: monospace;
}
.response-info {
    margin-top: 10px;
    font-weight: bold;
}
.success {
    color: #28a745;
}
.error {
    color: #dc3545;
}
.json-form {
    width: 100%;
    margin-bottom: 10px;
}
.json-editor {
    width: 100%;
    height: 150px;
    font-family: monospace;
    padding: 10px;
    border: 1px solid #ddd;
    margin-bottom: 10px;
}
EOF

cat > ${HTMLROOT}/css/uploads.css << 'EOF'
.upload-container {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
}
.upload-list {
    margin-top: 20px;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 10px;
}
.upload-status {
    margin-top: 10px;
    padding: 10px;
    border-radius: 4px;
    display: none;
}
.success {
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
}
.error {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}
.file-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #eee;
}
.file-item:last-child {
    border-bottom: none;
}
.file-item a {
    margin-left: 10px;
}
.file-info {
    display: flex;
    flex-direction: column;
}
.file-meta {
    font-size: 12px;
    color: #666;
    margin-top: 5px;
}
.refresh-btn {
    background-color: #6c757d;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 10px;
}
.refresh-btn:hover {
    background-color: #5a6268;
}
#directory-listing {
    font-family: monospace;
    white-space: pre-wrap;
    overflow-x: auto;
    background-color: #f5f5f5;
    padding: 15px;
    border-radius: 4px;
}
EOF

cat > ${HTMLROOT}/protected-resource/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Protected JSON Resource Testing</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/protected-resource.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Protected JSON Resource Testing</h1>
        </header>

        <main>
            <div id="get-section" class="test-section">
                <h2>GET JSON Resource</h2>
                <form id="get-form" method="get" action="/protected-resource/data.json">
                    <button type="submit" class="btn">Send GET Request</button>
                </form>
                <div id="get-result" class="result-area">
                    <p>Results will appear here...</p>
                </div>
            </div>

            <div id="post-section" class="test-section">
                <h2>Update JSON Content</h2>
                <form id="post-form" class="json-form" method="post" action="/protected-resource/" enctype="multipart/form-data">
                    <textarea id="post-content" name="file" class="json-editor"></textarea>
                    <button type="submit" class="btn">Update JSON Content</button>
                </form>
                <div id="post-result" class="result-area">
                    <p>Results will appear here...</p>
                </div>
            </div>

            <div id="delete-section" class="test-section">
                <h2>Delete JSON Resource</h2>
                <form id="delete-form" method="post" action="/protected-resource/data.json">
                    <input type="hidden" name="_method" value="DELETE">
                    <button type="submit" class="btn">Send DELETE Request</button>
                </form>
                <div id="delete-result" class="result-area">
                    <p>Results will appear here...</p>
                </div>
            </div>
        </main>

        <footer>
            <a href="/">Back to Home</a>
        </footer>
    </div>

    <script>
        function formatResponse(response, data) {
            let result = "";
            result += `Status: ${response.status} ${response.statusText}\n\n`;
            result += "Headers:\n";

            for (const [key, value] of response.headers.entries()) {
                result += `${key}: ${value}\n`;
            }

            result += "\nBody:\n";
            try {
                if (data && typeof data === 'string') {
                    const jsonObj = JSON.parse(data);
                    result += JSON.stringify(jsonObj, null, 2);
                } else {
                    result += data || "(Empty response)";
                }
            } catch (e) {
                result += data || "(Empty response)";
            }

            return result;
        }

        async function fetchJsonForEditing() {
            const editor = document.getElementById('post-content');
            editor.value = 'Loading JSON data...';

            try {
                const response = await fetch('/protected-resource/data.json');
                if (!response.ok) {
                    throw new Error(`Failed to fetch JSON: ${response.status} ${response.statusText}`);
                }

                const jsonData = await response.json();
                editor.value = JSON.stringify(jsonData, null, 2);
            } catch (error) {
                editor.value = `Error loading JSON: ${error.message}`;
            }
        }

        document.getElementById('get-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const resultDiv = document.getElementById('get-result');
            resultDiv.innerHTML = "<p>Sending request...</p>";

            try {
                const response = await fetch('/protected-resource/data.json', {
                    method: 'GET'
                });

                let data = await response.text();
                resultDiv.innerHTML = `<pre>${formatResponse(response, data)}</pre>`;

                resultDiv.innerHTML += `<p class="response-info ${response.ok ? 'success' : 'error'}">
                    Request ${response.ok ? 'succeeded' : 'failed'} with status ${response.status}
                </p>`;
            } catch (error) {
                resultDiv.innerHTML = `<p class="error">Error: ${error.message}</p>`;
            }
        });

        document.getElementById('post-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const resultDiv = document.getElementById('post-result');
            const content = document.getElementById('post-content').value;

            resultDiv.innerHTML = "<p>Updating JSON content...</p>";

            try {
                // JSON 유효성 검사
                try {
                    JSON.parse(content);
                } catch (jsonError) {
                    resultDiv.innerHTML = `<p class="error">Invalid JSON: ${jsonError.message}</p>`;
                    return;
                }

                // JSON 텍스트를 파일로 변환
                const jsonBlob = new Blob([content], {type: 'application/json'});
                const formData = new FormData();

                // 파일로 추가 (이 부분이 중요합니다)
                formData.append('file', jsonBlob, 'data.json');

                const response = await fetch('/protected-resource/', {
                    method: 'POST',
                    body: formData
                });

                let data = await response.text();
                resultDiv.innerHTML = `<pre>${formatResponse(response, data)}</pre>`;

                resultDiv.innerHTML += `<p class="response-info ${response.ok ? 'success' : 'error'}">
                    Request ${response.ok ? 'succeeded' : 'failed'} with status ${response.status}
                </p>`;

                if (response.ok) {
                    setTimeout(fetchJsonForEditing, 1000);
                }
            } catch (error) {
                resultDiv.innerHTML = `<p class="error">Error: ${error.message}</p>`;
            }
        });

        document.getElementById('delete-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const resultDiv = document.getElementById('delete-result');
            resultDiv.innerHTML = "<p>Sending request...</p>";

            try {
                const response = await fetch('/protected-resource/data.json', {
                    method: 'DELETE'
                });

                let data = await response.text();
                resultDiv.innerHTML = `<pre>${formatResponse(response, data)}</pre>`;

                resultDiv.innerHTML += `<p class="response-info ${response.ok ? 'success' : 'error'}">
                    Request ${response.ok ? 'succeeded' : 'failed'} with status ${response.status}
                </p>`;
            } catch (error) {
                resultDiv.innerHTML = `<p class="error">Error: ${error.message}</p>`;
            }
        });

        document.addEventListener('DOMContentLoaded', () => {
            fetchJsonForEditing();
            document.getElementById('get-form').dispatchEvent(new Event('submit'));
        });
    </script>
</body>
</html>
EOF

cat > ${HTMLROOT}/css/style.css << 'EOF'
body.preload {
    opacity: 0;
    transition: opacity 1s ease-in-out;
}
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    line-height: 1.6;
    background: linear-gradient(135deg, #74ABE2, #5563DE);
    color: #333;
    transition: opacity 1s ease-in-out, background-position 0.3s ease;
    background-attachment: fixed;
    background-position: center top;
}

.container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 30px;
    background-color: #ffffff;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    border-radius: 12px;
}

header {
    text-align: center;
    padding: 40px 0;
    background-color: rgba(0, 123, 255, 0.85);
    color: white;
    border-radius: 12px 12px 0 0;
    position: relative;
    transition: padding 0.3s ease;
}

header .logo {
    max-width: 180px;
    height: auto;
    margin-bottom: 15px;
}

nav ul {
    list-style: none;
    padding: 0;
    display: flex;
    justify-content: center;
    gap: 20px;
}

nav a {
    text-decoration: none;
    color: #333;
    font-weight: 600;
    padding: 5px 10px;
    font-size: 12px;
    border-radius: 50px;
    transition: transform 0.3s ease-in-out, background-color 0.3s ease;
    text-transform: uppercase;
    background-color: rgba(255, 255, 255, 0.8);
}

nav a:hover {
    background-color: #007bff;
    color: white;
    transform: translateY(-3px);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

main {
    padding: 30px 0;
}

h1, h2 {
    color: #333;
    font-weight: bold;
    font-size: 28px;
    margin-bottom: 15px;
}

section {
    margin-bottom: 40px;
}

form {
    display: flex;
    flex-direction: column;
    gap: 20px;
    max-width: 500px;
    margin: 0 auto;
}

input[type="file"] {
    padding: 10px;
    border-radius: 8px;
    border: 2px solid #ccc;
    font-size: 16px;
    transition: border-color 0.3s ease;
}

input[type="file"]:focus {
    border-color: #007bff;
    outline: none;
}

button {
    background-color: #007bff;
    color: white;
    padding: 12px 25px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

button:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}

footer {
    text-align: center;
    padding: 20px 0;
    background-color: #f1f1f1;
    border-top: 1px solid #ccc;
    margin-top: 50px;
}

@media (max-width: 768px) {
    nav ul {
        flex-direction: column;
        gap: 15px;
    }
    header {
        padding: 30px 0;
    }
    .container {
        padding: 20px;
    }
    button, input[type="file"] {
        width: 100%;
    }
}
EOF

cat > ${HTMLROOT}/js/main.js << 'EOF'
document.addEventListener('DOMContentLoaded', function() {
    document.body.classList.remove('preload');

    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (window.pageYOffset > 50) {
            header.style.padding = "20px 0";
        } else {
            header.style.padding = "40px 0";
        }
    });

    const navLinks = document.querySelectorAll('nav a[href^="#"]');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetID = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetID);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop,
                    behavior: "smooth"
                });
            }
        });
    });

    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        document.body.style.backgroundPosition = 'center ' + (scrolled * 0.5) + 'px';
    });

    const navLinkElements = document.querySelectorAll('nav a');
    navLinkElements.forEach(link => {
        link.addEventListener('mouseover', function() {
            this.style.transform = 'translateY(-3px)';
        });
        link.addEventListener('mouseout', function() {
            this.style.transform = 'translateY(0)';
        });
    });
});
EOF

cat > ${HTMLROOT}/error/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>404 - Page Not Found</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h1>404 - Page Not Found</h1>
        <p>The page you are looking for does not exist.</p>
        <a href="/">Return to Home</a>
    </div>
</body>
</html>
EOF

cat > ${HTMLROOT}/error/500.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>500 - Internal Server Error</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h1>500 - Internal Server Error</h1>
        <p>Something went wrong on our end. Please try again later.</p>
        <a href="/">Return to Home</a>
    </div>
</body>
</html>
EOF

cat > ${HTMLROOT}/directory/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Directory Test</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Directory Listing Test</h1>
        </header>
        <main>
            <section id="get-test">
                <h2>GET Test</h2>
                <p>This section tests GET requests.</p>
                <ul>
                    <li><a href="/directory/file1.txt">Sample Text File</a></li>
                    <li><a href="/directory/file2.pdf">Sample PDF File</a></li>
                </ul>
            </section>

            <section id="directory-actions">
                <h2>Directory Actions</h2>
                <button id="delete-index" class="danger-btn">Delete Index File</button>
                <div id="action-status"></div>
            </section>
        </main>
        <footer>
            <a href="/">Back to Home</a>
        </footer>
    </div>

    <script>
        document.getElementById('delete-index').addEventListener('click', async () => {
            const statusDiv = document.getElementById('action-status');
            statusDiv.textContent = `Attempting to delete index.html...`;

            try {
                const response = await fetch(`/directory/index.html`, {
                    method: 'DELETE'
                });

                if (!response.ok) {
                    throw new Error(`Failed to delete: ${response.status} ${response.statusText}`);
                }

                statusDiv.textContent = `Successfully deleted index.html. Redirecting to homepage...`;
                statusDiv.classList.add('success');
                statusDiv.classList.remove('error');

                setTimeout(() => {
                    window.location.href = '/';
                }, 1500);
            } catch (error) {
                statusDiv.textContent = `Failed to delete file: ${error.message}`;
                statusDiv.classList.add('error');
                statusDiv.classList.remove('success');
            }
        });
    </script>

    <style>
        .danger-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        .danger-btn:hover {
            background-color: #c82333;
        }

        #action-status {
            margin-top: 15px;
            padding: 10px;
            border-radius: 4px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</body>
</html>
EOF

cat > ${HTMLROOT}/directory/file1.txt << 'EOF'
This is a test file for GET request testing.
EOF

convert xc:white -page A4 -font Helvetica -pointsize 20 -draw "text 50,50 'Test PDF File'" ${HTMLROOT}/directory/file2.pdf

cat > ${HTMLROOT}/new-page/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>New Page</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Redirected Successfully</h1>
        </header>
        <main>
            <p>You have been redirected from /old-page to /new-page</p>
        </main>
        <footer>
            <a href="/">Return to Home</a>
        </footer>
    </div>
</body>
</html>
EOF

cat > ${HTMLROOT}/about/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>About - Test Site</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h1>About Page</h1>
        <p>This is a test page for the About section.</p>
        <a href="/">Return to Home</a>
    </div>
</body>
</html>
EOF

cat > ${HTMLROOT}/contact/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Contact - Test Site</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Contact Page</h1>
        <p>This is a test page for the Contact section.</p>
        <a href="/">Return to Home</a>
    </div>
</body>
</html>
EOF

chmod 777 ${HTMLROOT}/uploads
chown www-data:www-data ${HTMLROOT}/uploads

touch ${LOGDIR}/access.log ${LOGDIR}/error.log
chown www-data:www-data ${LOGDIR}/*.log
chmod 644 ${LOGDIR}/*.log

convert -size 200x100 xc:white -draw "text 50,50 'Test Site'" ${HTMLROOT}/images/logo.png
chown www-data:www-data ${HTMLROOT}/images/logo.png

touch ${HTMLROOT}/empty-directory/.keep

chmod 755 ${HTMLROOT}/directory
chmod 755 ${HTMLROOT}/empty-directory
chmod 644 ${HTMLROOT}/directory/index.html

cat > ${CGIROOT}/test.php << 'EOF'
<?php
header("Content-Type: text/html; charset=UTF-8");
echo "<html><body>\n";
echo "<h1>CGI Test</h1>\n";

echo "<h2>CGI Environment:</h2>\n";
echo "<pre>\n";
echo "REQUEST_METHOD: " . $_SERVER['REQUEST_METHOD'] . "\n";
echo "QUERY_STRING: " . $_SERVER['QUERY_STRING'] . "\n";
echo "SCRIPT_NAME: " . $_SERVER['SCRIPT_NAME'] . "\n";
echo "CONTENT_TYPE: " . (isset($_SERVER['CONTENT_TYPE']) ? $_SERVER['CONTENT_TYPE'] : 'Not Set') . "\n";
echo "CONTENT_LENGTH: " . (isset($_SERVER['CONTENT_LENGTH']) ? $_SERVER['CONTENT_LENGTH'] : 'Not Set') . "\n";
echo "</pre>\n";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    echo "<h2>POST Data:</h2>\n";
    echo "<pre>\n";

    $raw_post = file_get_contents('php://input');
    echo "Raw POST data (" . strlen($raw_post) . " bytes):\n";
    echo htmlspecialchars($raw_post) . "\n\n";

    echo "POST variables:\n";
    if (!empty($_POST)) {
        foreach ($_POST as $key => $value) {
            echo htmlspecialchars($key) . ": " . htmlspecialchars($value) . "\n";
        }
    } else {
        echo "No parsed POST variables\n";
    }
    echo "</pre>\n";
}

if (!empty($_GET)) {
    echo "<h2>GET Variables:</h2>\n";
    echo "<pre>\n";
    foreach ($_GET as $key => $value) {
        echo htmlspecialchars($key) . ": " . htmlspecialchars($value) . "\n";
    }
    echo "</pre>\n";
}

echo "<h2>All Environment Variables:</h2>\n";
echo "<pre>\n";
foreach ($_SERVER as $key => $value) {
    echo htmlspecialchars($key) . ": " . htmlspecialchars($value) . "\n";
}
echo "</pre>\n";

echo "</body></html>\n";
?>
EOF

cat > ${HTMLROOT}/cgi-test.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>CGI Test Forms</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h1>CGI Test Forms</h1>

        <section>
            <h2>Simple POST Form</h2>
            <form action="/cgi-bin/test.php" method="post">
                <div>
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div>
                    <label for="message">Message:</label>
                    <textarea id="message" name="message" required></textarea>
                </div>
                <button type="submit">Submit</button>
            </form>
        </section>

        <section>
            <h2>URL Encoded POST Test</h2>
            <form action="/cgi-bin/test.php" method="post" enctype="application/x-www-form-urlencoded">
                <div>
                    <label for="data">Data:</label>
                    <input type="text" id="data" name="data" required>
                </div>
                <button type="submit">Send URL Encoded</button>
            </form>
        </section>

        <section>
            <h2>Raw POST Test</h2>
            <form action="/cgi-bin/test.php" method="post" enctype="text/plain">
                <div>
                    <label for="raw">Raw Data:</label>
                    <textarea id="raw" name="raw" required></textarea>
                </div>
                <button type="submit">Send Raw</button>
            </form>
        </section>

        <section>
            <h2>GET Test with Query String</h2>
            <form action="/cgi-bin/test.php" method="get">
                <div>
                    <label for="query">Query:</label>
                    <input type="text" id="query" name="query" required>
                </div>
                <button type="submit">Send GET</button>
            </form>
        </section>

        <section>
            <h2>Additional Test Scripts</h2>
            <p>The following links are for testing specific error cases and resource usage:</p>
            <ul>
                <li><a href="/cgi-bin/memory_hog.php">Memory Usage Test</a> - Uses large amounts of memory</li>
                <li><a href="/cgi-bin/infinite_loop.php">Infinite Loop Test</a> - Runs continuously until timeout</li>
                <li><a href="/cgi-bin/crash_test.php">Fatal Error Test</a> - Triggers a PHP fatal error</li>
                <li><a href="/cgi-bin/syntax_error.php">Syntax Error Test</a> - Contains a PHP syntax error</li>
            </ul>
        </section>
    </div>
</body>
</html>
EOF

chmod 755 ${CGIROOT}/test.php
chown www-data:www-data ${CGIROOT}/test.php
chmod 644 ${HTMLROOT}/cgi-test.html
chown www-data:www-data ${HTMLROOT}/cgi-test.html

echo "Test site and CGI setup has been created successfully!"

cat > ${HTMLROOT}/uploads/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>File Upload Test</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/uploads.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>File Upload Test</h1>
        </header>
        <main class="upload-container">
            <section id="post-test">
                <h2>File Upload Test</h2>
                <form action="/uploads" method="post" enctype="multipart/form-data" id="file-upload-form">
                    <div>
                        <input type="file" name="file" id="file-input" multiple>
                    </div>
                    <button type="submit">Upload</button>
                </form>
                <div id="upload-status" class="upload-status"></div>
            </section>

            <section id="store-files">
                <h2>Store Directory</h2>
                <button class="refresh-btn" id="refresh-btn">Refresh File List</button>
                <div class="upload-list" id="store-file-list">
                    <div id="directory-listing">Loading files...</div>
                </div>
            </section>
        </main>
        <footer>
            <a href="/">Back to Home</a>
        </footer>
    </div>

    <script>
        document.getElementById('file-upload-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const statusDiv = document.getElementById('upload-status');

            try {
                const response = await fetch('/uploads', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    const text = await response.text();
                    throw new Error(text || 'Upload failed');
                }

                statusDiv.textContent = 'File uploaded successfully!';
                statusDiv.className = 'upload-status success';
                statusDiv.style.display = 'block';

                loadStoreDirectory();
            } catch (error) {
                statusDiv.textContent = 'Failed to upload file: ' + error.message;
                statusDiv.className = 'upload-status error';
                statusDiv.style.display = 'block';
            }
        });

        function loadStoreDirectory() {
            const storeFileList = document.getElementById('store-file-list');
            storeFileList.innerHTML = '<div id="directory-listing">Loading files...</div>';

            fetch('/store/', { method: 'GET' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`Failed to get directory listing: ${response.status}`);
                    }
                    return response.text();
                })
                .then(html => {
                    const tempDiv = document.createElement('div');
                    tempDiv.innerHTML = html;

                    const links = Array.from(tempDiv.querySelectorAll('a'));
                    let fileList = '';

                    links.forEach(link => {
                        const fileName = link.textContent.trim();
                        const href = link.getAttribute('href') || '';

                        if (fileName &&
                            !fileName.includes('Parent Directory') &&
                            !fileName.includes('Back to Home') &&
                            fileName !== '.' &&
                            fileName !== '..' &&
                            !href.includes('..') &&
                            !href.endsWith('/')) {

                            fileList += `<div class="file-item">
                                <div class="file-info">
                                    <span>${fileName}</span>
                                </div>
                                <div>
                                    <a href="/store/${fileName}">Download</a>
                                    <button class="delete-file" data-file="${fileName}">Delete</button>
                                </div>
                            </div>`;
                        }
                    });

                    if (fileList) {
                        storeFileList.innerHTML = fileList;

                        document.querySelectorAll('.delete-file').forEach(button => {
                            button.addEventListener('click', async () => {
                                const file = button.getAttribute('data-file');
                                if (confirm(`Are you sure you want to delete ${file}?`)) {
                                    try {
                                        const response = await fetch(`/store/${file}`, {
                                            method: 'DELETE'
                                        });

                                        if (!response.ok) {
                                            throw new Error(`Failed to delete: ${response.status} ${response.statusText}`);
                                        }

                                        alert(`${file} has been deleted.`);
                                        loadStoreDirectory();
                                    } catch (error) {
                                        alert(`Error: ${error.message}`);
                                    }
                                }
                            });
                        });
                    } else {
                        storeFileList.innerHTML = `
                            <p>No files found in the directory or directory indexing is disabled.</p>
                            <div class="file-item">
                                <div class="file-info">
                                    <span>sample.txt</span>
                                </div>
                                <div>
                                    <a href="/store/sample.txt">Download</a>
                                    <button class="delete-file" data-file="sample.txt">Delete</button>
                                </div>
                            </div>
                            <div class="file-item">
                                <div class="file-info">
                                    <span>sample.json</span>
                                </div>
                                <div>
                                    <a href="/store/sample.json">Download</a>
                                    <button class="delete-file" data-file="sample.json">Delete</button>
                                </div>
                            </div>
                        `;

                        document.querySelectorAll('.delete-file').forEach(button => {
                            button.addEventListener('click', function() {
                                const file = this.getAttribute('data-file');
                                if (confirm(`Are you sure you want to delete ${file}?`)) {
                                    fetch(`/store/${file}`, {
                                        method: 'DELETE'
                                    })
                                    .then(response => {
                                        if (!response.ok) {
                                            throw new Error(`Failed to delete: ${response.status} ${response.statusText}`);
                                        }
                                        alert(`${file} has been deleted.`);
                                        loadStoreDirectory();
                                    })
                                    .catch(error => {
                                        alert(`Error: ${error.message}`);
                                    });
                                }
                            });
                        });
                    }
                })
                .catch(error => {
                    storeFileList.innerHTML = `<p class="error">Error: ${error.message}</p>`;
                });
        }

        document.getElementById('refresh-btn').addEventListener('click', function() {
            loadStoreDirectory();
        });

        document.addEventListener('DOMContentLoaded', function() {
            loadStoreDirectory();
        });
    </script>
</body>
</html>
EOF

chmod 777 ${HTMLROOT}/uploads
chmod 777 ${HTMLROOT}/store
chown www-data:www-data ${HTMLROOT}/uploads
chown www-data:www-data ${HTMLROOT}/store
chown www-data:www-data ${HTMLROOT}/uploads/*

cat > ${HTMLROOT}/uploads/status.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Upload Status</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Upload Status</h1>
        <div id="status-message"></div>
        <a href="/uploads">Back to Upload Page</a>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        const status = params.get('status');
        const message = params.get('message');
        const statusDiv = document.getElementById('status-message');

        if (status === 'success') {
            statusDiv.innerHTML = `<div class="success">File uploaded successfully!</div>`;
        } else {
            statusDiv.innerHTML = `<div class="error">Upload failed: ${message || 'Unknown error'}</div>`;
        }
    </script>
</body>
</html>
EOF

cat > ${CGIROOT}/memory_hog.php << 'EOF'
<?php
header("Content-Type: text/html; charset=UTF-8");
echo "<html><body>\n";
echo "<h1>Memory Resource Test</h1>\n";
echo "<p>This script will attempt to use a lot of memory</p>\n";

$array = array();
for ($i = 0; $i < 50000; $i++) {
    $array[] = $i . '-' . date('Y-m-d H:i:s') . '-' . bin2hex(random_bytes(500));
    echo "<p>Memory block $i allocated</p>\n";
    flush();
}

echo "</body></html>\n";
?>
EOF

cat > ${CGIROOT}/crash_test.php << 'EOF'
<?php
header("Content-Type: text/html; charset=UTF-8");
echo "<html><body>\n";
echo "<h1>Crash Test</h1>\n";
echo "<p>This script will attempt to crash by triggering a fatal error</p>\n";

non_existent_function();

echo "</body></html>\n";
?>
EOF

cat > ${CGIROOT}/syntax_error.php << 'EOF'
<?php
header("Content-Type: text/html; charset=UTF-8")
echo "<html><body>\n";
echo "<h1>Syntax Error Test</h1>\n";
echo "<p>This script contains a syntax error.</p>\n";
echo "</body></html>\n";
?>
EOF

cat > ${CGIROOT}/infinite_loop.php << 'EOF'
<?php
header("Content-Type: text/html; charset=UTF-8");
echo "<html><body>\n";
echo "<h1>Infinite Loop Test</h1>\n";
echo "<p>This script contains an infinite loop. The server should timeout this request.</p>\n";

while(true) {
    file_put_contents('/tmp/loop.log', '.', FILE_APPEND);
    flush();
    sleep(1);
}

echo "</body></html>\n";
?>
EOF

chmod 755 ${CGIROOT}/*.php
chown www-data:www-data ${CGIROOT}/*.php

echo "Test site has been created successfully!"

cat > ${HTMLROOT}/cgi-test/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>CGI Testing</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>CGI Test</h1>
        </header>

        <main>
            <section id="cgi-test-links">
                <h2>CGI Test Links</h2>
                <ul>
                    <li><a href="/cgi-bin/test.php">Basic CGI Test</a></li>
                    <li><a href="/cgi-bin/test.php?name=test">CGI with Query String</a></li>
                    <li><a href="/cgi-bin/memory_hog.php">Memory Test</a></li>
                    <li><a href="/cgi-bin/infinite_loop.php">Timeout Test</a></li>
                    <li><a href="/cgi-bin/crash_test.php">Error Test</a></li>
                    <li><a href="/cgi-bin/syntax_error.php">Syntax Error Test</a></li>
                </ul>
            </section>

            <section id="cgi-test-post">
                <h2>POST Test</h2>
                <form action="/cgi-bin/test.php" method="post">
                    <input type="text" name="data" placeholder="Enter test data">
                    <button type="submit">Test POST</button>
                </form>
            </section>
        </main>

        <footer>
            <a href="/">Back to Home</a>
        </footer>
    </div>

    <style>
        form {
            margin: 20px 0;
            display: flex;
            gap: 10px;
        }
        input[type="text"] {
            flex-grow: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</body>
</html>
EOF

echo "Test site has been created successfully!"

cat > ${HTMLROOT}/store/sample.txt << 'EOF'
This is a sample text file for testing file downloads.
EOF

cat > ${HTMLROOT}/store/sample.json << 'EOF'
{
  "id": 1,
  "name": "Sample JSON",
  "description": "This is a sample JSON file for testing file downloads"
}
EOF

chmod -R 755 ${HTMLROOT}/store
chmod 644 ${HTMLROOT}/store/*
chown -R www-data:www-data ${HTMLROOT}/store
