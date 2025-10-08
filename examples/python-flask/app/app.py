"""Simple Flask application example."""
import os
from flask import Flask, jsonify
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Configuration
app.config['PORT'] = int(os.getenv('PORT', 5000))
app.config['ENV'] = os.getenv('FLASK_ENV', 'development')


@app.route('/')
def index():
    """Welcome endpoint."""
    return jsonify({
        'message': 'Welcome to the Python Flask example!',
        'docs': 'This project uses Cursor Environment Docs',
        'tip': 'Check .cursor/project-environment.mdc for environment details'
    })


@app.route('/health')
def health():
    """Health check endpoint."""
    return jsonify({
        'status': 'healthy',
        'python_version': os.sys.version
    })


@app.route('/env')
def env_info():
    """Environment information endpoint."""
    return jsonify({
        'flask_env': app.config['ENV'],
        'port': app.config['PORT'],
        'debug': app.debug
    })


if __name__ == '__main__':
    port = app.config['PORT']
    print(f"🚀 Server running on http://localhost:{port}")
    print("📚 Environment docs: .cursor/project-environment.mdc")
    print("🔍 Check staleness: ./.cursor/check-env-docs.sh (or .ps1)")
    
    app.run(
        host='0.0.0.0',
        port=port,
        debug=(app.config['ENV'] == 'development')
    )

