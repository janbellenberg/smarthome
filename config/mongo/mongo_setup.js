db = db.getSiblingDB('smarthome');
db.createCollection("sessions");
db.createCollection("settings");

db.settings.insertOne({
  mail:{
    username: "",
    password: "",
    host: "SMTP.office365.com",
    port: 587,
    sender: ""
  },
  versions:{
    api: 1.0,
    app: 1.0,
    protocol: 1.0
  }
});

db.createUser({
  user: "smarthome",
  pwd: "gXg33Ep4urGp6bF2",
  roles: [{role: "readWrite", db: "smarthome"}]
});