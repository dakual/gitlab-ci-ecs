from datetime import datetime
from flask import Flask, jsonify
import uuid
import psutil

app = Flask(__name__)

@app.route("/")
def index():
  data = {}
  data["cpu"]  = psutil.cpu_percent(interval=0.9)
  data["mem"]  = psutil.virtual_memory().percent
  data["disk"] = psutil.disk_usage("/").percent
  # data["processes"] = []
  # for proc in psutil.process_iter():
  #     try:
  #         pinfo = proc.as_dict(
  #             attrs=["pid", "name", "memory_percent", "num_threads", "cpu_times"]
  #         )
  #     except psutil.NoSuchProcess:
  #         pass
  #     else:
  #         data["processes"].append(pinfo)

  return jsonify(
      id = uuid.uuid1(), 
      type = "OS Utilizations",
      timestamp = datetime.now(),
      data = data
  )


if __name__ == "__main__":
  app.run(host="0.0.0.0", port=5000, debug=True)