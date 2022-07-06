module.exports = (sequelize, DataTypes) => {
  const Incident = sequelize.define(
    "Incident",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      date: {
        type: DataTypes.DATE,
        allowNull: false,
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

  Incident.associate = (models) => {
    Incident.belongsTo(models.Category);
    Incident.belongsTo(models.User);
  };

  return Incident;
};
