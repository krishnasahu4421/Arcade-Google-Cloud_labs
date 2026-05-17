# 🌐 Develop Serverless Apps with Firebase: Challenge Lab || GSP344 🚀 [![Open Lab](https://img.shields.io/badge/Open-Lab-blue?style=flat)](https://www.cloudskillsboost.google/course_templates/649/labs/550917)

## ⚠️ Disclaimer ⚠️

<blockquote style="background-color: #fffbea; border-left: 6px solid #f7c948; padding: 1em; font-size: 15px; line-height: 1.5;">
  <strong>Educational Purpose Only:</strong> This script and guide are provided for the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services.
  <br><br>
  <strong>Terms Compliance:</strong> Always ensure compliance with Qwiklabs' terms of service and YouTube's community guidelines. The aim is to enhance your learning experience — not to circumvent it.
</blockquote>

---

<div style="padding: 15px; margin: 10px 0;">

## ☁️ Run in Cloud Shell:

```bash
curl -LO raw.githubusercontent.com/LabKing21/Arcade-Google-Cloud_Labs/refs/heads/main/Develop%20Serverless%20Apps%20with%20Firebase%3A%20Challenge%20Lab/LabKing.sh
sudo chmod +x LabKing.sh
./LabKing.sh
```
## ☁️ Run in Cloud Shell:

```bash
cd ~/pet-theory/lab06/firebase-frontend
```
```bash
gcloud builds submit --tag us-east1-docker.pkg.dev/$GOOGLE_CLOUD_PROJECT/frontend-repo/frontend-staging:0.1
```
```bash
gcloud run deploy frontend-staging-service \

    --image=us-east1-docker.pkg.dev/$GOOGLE_CLOUD_PROJECT/frontend-repo/frontend-staging:0.1 \

    --platform=managed \

    --region=us-east1 \

    --allow-unauthenticated \

    --max-instances=1
```
```bash
# Navigate to the public assets directory

cd ~/pet-theory/lab06/firebase-frontend/public

# Swap out the placeholder URL with your actual live REST API Service URL

sed -i "s|https://netflix-dataset-service-abcdef-uc.a.run.app|$SERVICE_URL|g" app.js
```
</div>

---

## 🎉 **Congratulations! Lab Completed Successfully!** 🏆  


---

<div align="center">
  <p style="font-size: 12px; color: #586069;">
    <em>This guide is provided for educational purposes. Always follow Qwiklabs terms of service and YouTube's community guidelines.</em>

</div>
