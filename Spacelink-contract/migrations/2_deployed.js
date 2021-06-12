const Migrations = artifacts.require("Mycontract");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
