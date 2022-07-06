
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    "User",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      username: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
      },
      displayName: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      password: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      timestamps: false,
    }
  );

  User.associate = (models) => {
    
    User.hasOne(models.Admin, {
      // onDelete: "cascade",
    });

    User.hasOne(models.Provider, {
      // onDelete: "cascade",
    });

    User.hasOne(models.CimtUser, {
      // onDelete: "cascade",
    });

    User.hasMany(models.Resource, {
    });

    User.hasMany(models.Incident, {
    });
  };

  return User
};
