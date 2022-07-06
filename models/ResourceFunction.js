module.exports = (sequelize, DataTypes) => {
  const ResourceFunction = sequelize.define(
    "ResourceFunction",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      description: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      timestamps: false,
    }
  );
  ResourceFunction.associate = (models) => {
    ResourceFunction.belongsToMany(models.Resource,{through:'FunctionTypeResource'});
  };

  return ResourceFunction;
};
