const express = require("express");
const router = express.Router();
const { Incident, User, Category } = require("../models");

router.post("/", (req, res) => {
  let data = {
    id: req.body.id,
    date: req.body.date,
    description: req.body.description,
  };
  Incident.create(data).then((response) => {
    return res.json(response);
  });
});
router.get("/", async (req, res) => {
  try {
    const response = await Incident.findAll({ include: [User, Category] });
    res.json(response);
  } catch (err) {
    console.log(err);
  }
});

module.exports = router;
