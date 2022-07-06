module.exports = (sequelize, DataTypes) => {
  const Resource = sequelize.define(
    "Resource",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      name: {
        type: DataTypes.STRING,
        allowNull: false,
      },

      description: {
        type: DataTypes.STRING,
      },
      capability: {
        type: DataTypes.TEXT,
      },
      distance: {
        type: DataTypes.FLOAT,
      },
      cost: {
        type: DataTypes.FLOAT,
        allowNull: false,
      },
    },
    {
      timestamps: false,
    }
  );

  Resource.associate = (models) => {
    Resource.belongsToMany(models.ResourceFunction, {
      through: "FunctionTypeResource",
    });
    Resource.belongsToMany(models.FunctionType, {
      through: "FunctionTypeResource",
    });

    Resource.belongsTo(models.User);
    Resource.belongsTo(models.Unit);
  };

  return Resource;
};
