from flask import Flask
from flask_socketio import SocketIO, emit
from flask_cors import CORS
import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = Flask(__name__)
app.config['SECRET_KEY'] = 'your_secret_key'

# Enable CORS only for http://localhost:3000 on all routes
CORS(app, resources={r"/*": {"origins": "http://localhost:3000"}})

# Initialize SocketIO with CORS allowed only for http://localhost:3000
socketio = SocketIO(app, cors_allowed_origins=["http://localhost:3000"])

@app.route('/')
def index():
    logger.info("HTTP GET request received at /")
    return "Server is working"
@app.route('/test')
def test():
    logger.info("HTTP GET request received at /test route")
    return "Test route"

@socketio.on('message')
def handle_message(message):
    logger.info("Received WebSocket message: %s", message)
    response_msg = f"Message received: {message}"
    emit('response', {'data': response_msg})
    logger.info("Response sent back to client: %s", response_msg)

if __name__ == '__main__':
    logger.info("Starting Flask server with WebSocket and restricted CORS (http://localhost:3000)")
    socketio.run(app, debug=True)
