const express = require("express");
const { Op } = require("sequelize");
const router = express.Router();
const {
  Resource,
  User,
  FunctionTypeResource,
  ResourceFunction,
  FunctionType,
  Unit,
} = require("../models");

router.post("/", (req, res) => {
  let data = {
    name: req.body.name,
    description: req.body.description,
    capability: req.body.capability,
    distance: req.body.distance,
    cost: req.body.cost,
    // unit: req.body.unit,
  };
  Resource.create(data).then((response) => {
    return res.json(response);
  });
});

router.get("/", async (req, res) => {
  try {
    const response = await Resource.findAll(
      {
        include: [
          FunctionTypeResource,
          User,
          ResourceFunction,
          FunctionType,
          Unit,
        ],
      },
      {
        attributes: {
          include: [
            [
              sequelize.fn("COUNT", sequelize.col("functionTypeResources.id")),
              "TotalResources",
            ],
          ],
        },
      }
    );
    return res.json(response);
  } catch (err) {
    console.log(err);
  }
});
// const amount=await table.count({where:{ id:{[Op.gt]: 1}}});

//  const{count,rows}=await table.findAndCountAll({
//   where:{ title:{[Op.like]: "%a%"}},
// })

router.get("/:userId", async (req, res) => {
  try {
    const response = await Resource.findAll(
      {
        include: [
          FunctionTypeResource,
          User,
          ResourceFunction,
          FunctionType,
          Unit,
        ],
      },
      {
        where: {
          userId: req.params.userId,
        },
      }
    );
    return res.json(response);
  } catch (error) {
    console.log(error);
  }
});

router.get("/:userId", async (req, res) => {
  try {
    const response = await Resource.findAll(
      {
        include: [
          FunctionTypeResource,
          User,
          ResourceFunction,
          FunctionType,
          Unit,
        ],
        order: [sequelize.fn("min", sequelize.col("distance"))],
      },
      {
        [Op.or]: [
          {
            resourceName: {
              [Op.like]: `%${req.params.search}%`,
            },
            description: {
              [Op.like]: "%" + req.params.search + "%",
            },
            // capability: req.params.search,
            // distance: req.params.search,
            // cost: req.params.search,
            // name: req.params.search,
            capability: {
              [Op.like]: "%" + req.params.search + "%",
            },
          },
        ],
      }
    );
    return res.json(response);
  } catch (error) {
    console.log(error);
  }
});

// router.get("/", async (req, res) => {
//   try {
//     const { name } = req.params;
//     const response = await Resource.findOne({ where: { name: name } });
//     res.json(response);
//   } catch (err) {
//     console.log(err);
//   }
// });

module.exports = router;
