module.exports = (sequelize, DataTypes) => {
  const FunctionType = sequelize.define(
    "FunctionType",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      typeName: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      timestamps: false,
    }
  );

  FunctionType.associate = (models) => {
    FunctionType.belongsToMany(models.Resource, {
      through: "FunctionTypeResource",
    });
  };

  return FunctionType;
};
