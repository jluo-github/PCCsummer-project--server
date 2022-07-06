module.exports = (sequelize, DataTypes) => {
  const Provider = sequelize.define(
    "Provider",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      address: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      timestamps: false,
    }
  );

  Provider.associate = (models) => {
    // Provider.belongsTo(models.user,
    //   // { foreignKey: "UserId" }
    // );
  };

  return Provider;
};
