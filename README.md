Title & Description:  
End‑to‑End DevOps Pipeline for Node.js Web Application.

Tech Stack:  
GitHub, Jenkins, Docker, AWS EC2, Prometheus, Grafana, Bash + Cron.

Setup Instructions:

bash
# Clone repo
git clone https://github.com/username/nodejs-devops-capstone.git
cd nodejs-devops-capstone

# Build Docker image
docker build -t nodejs-capstone .

# Run locally
docker run -p 3000:3000 nodejs-capstone
CI/CD Flow:

Developer pushes code → Jenkins triggers build → Docker image pushed → EC2 deploys container → Prometheus & Grafana monitor → Cron jobs automate backups & cleanup.

✅ This draft is now a complete project report. You just need to:

Insert your screenshots.

Add your GitHub repo link.

Add your EC2 public IP if deployed.
Monitoring & Automation
- **prometheus.yml** → Prometheus configuration file for scraping Node Exporter metrics.
- **backup.sh** → Bash script to back up logs/data to S3.
- **cleanup.sh** → Bash script to clean old logs (7+ days).
