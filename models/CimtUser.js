module.exports = (sequelize, DataTypes) => {
  const CimtUser = sequelize.define(
    "CimtUser",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      phone: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      timestamps: false,
    }
  );

  CimtUser.associate = (models) => {
    // CimtUser.belongsTo(models.user, {

    // });
  };

  return CimtUser;
};
