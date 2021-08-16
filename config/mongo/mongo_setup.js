db = db.getSiblingDB('smarthome');
db.createCollection("sessions");
db.createCollection("settings");

db.createUser({
  user: "smarthome",
  pwd: "gXg33Ep4urGp6bF2",
  roles: [{role: "readWrite", db: "smarthome"}]
});