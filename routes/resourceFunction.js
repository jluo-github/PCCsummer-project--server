const express = require("express");
const router = express.Router();
const { ResourceFunction } = require("../models");

router.post("/", async (req, res) => {
  try {
    const { id, description } = req.body;
    await ResourceFunction.create({
      id: id,
      description: description,
    });
    res.json("ResourceFunction created");
  } catch (err) {
    console.log(err);
  }
});

router.get("/", (req, res) => {
  ResourceFunction.findAll()
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving ResourceFunctions.",
      });
    });
});

module.exports = router;
