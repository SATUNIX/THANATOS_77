import os
from flask import Flask, render_template, request, send_file, redirect
import requests

app = Flask(__name__)

# Define the directory for storing uploaded files
UPLOAD_DIRECTORY = os.path.join(os.getcwd(), "uploads")

@app.route("/")
def index():
    # Get a list of all files in the upload directory
    files = os.listdir(UPLOAD_DIRECTORY)
    # Render the HTML template with the list of files
    return render_template("index.html", files=files)

@app.route("/upload", methods=["POST"])
def upload():
    # Get the uploaded file from the request
    files = os.listdir(UPLOAD_DIRECTORY)
    uploaded_file = request.files.get("file")
    url = request.form.get('url')

    if uploaded_file:
        # Save the file to the upload directory
        filename = uploaded_file.filename
        uploaded_file.save(os.path.join(UPLOAD_DIRECTORY, filename))

    elif url:
        try:
            response = requests.get(url)
            response.raise_for_status()
        except requests.exceptions.RequestException as e:
            return f'Error downloading file: {e}', 500

        filename = url.split("/")[-1]
        save_path = os.path.join(UPLOAD_DIRECTORY, filename)

        with open(save_path, 'wb') as f:
            f.write(response.content)

    else:
        return "No file or URL provided", 400

    return render_template("index.html", files=files)

@app.route("/download/<filename>")
def download(filename):
    # Construct the path to the file
    path = os.path.join(UPLOAD_DIRECTORY, filename)
    # Send the file to the client for download
    return send_file(path, as_attachment=True)

if __name__ == "__main__":
    # Create the upload directory if it does not exist
    if not os.path.exists(UPLOAD_DIRECTORY):
        os.makedirs(UPLOAD_DIRECTORY)
    app.run(host="0.0.0.0", port="8000", debug=True)
