const Data = require("../models/burial");

module.exports = {
    // [POST]
    async createBurialData(req, res) {
        try {
            return new Data(req.body)
                .save()
                .then((value) => res.status(200).json(value))
                .catch((err) => res.status(400).send(err.errors));
        } catch (error) {
            console.error(error);
        }
    },
    // [GET]
    async getBurialData(req, res) {
        try {
            const firstName = req.query.firstName;
            const lastName = req.query.lastName;

            const deathDayStart = new Date(req.query.deathDateStart);
            const deathDateEnd = new Date(req.query.deathDateEnd);
            const _select =
                req.query.searchBy == "admin" ?
                { __v: 0 } :
                { __v: 0, registrant: 0, movant: 0 };

            return Data.find({
                    "deceased.profile.firstName": { $regex: firstName, $options: "i" },
                    "deceased.profile.lastName": { $regex: lastName, $options: "i" },
                    "deceased.date.death": {
                        $gte: new Date(
                            deathDayStart.getFullYear(),
                            deathDayStart.getMonth(),
                            deathDayStart.getDate() + 1
                        ),
                        $lt: new Date(
                            deathDateEnd.getFullYear(),
                            deathDateEnd.getMonth(),
                            deathDateEnd.getDate() + 1
                        ),
                    },
                })
                .sort({ _id: -1 }) // filter by _id
                .select(_select) // Do not return  __v and registrant
                .then((value) => res.status(200).json(value))
                .catch((err) => res.status(400).json(err));
        } catch (error) {
            console.error(error);
        }
    },
    async getAllBurialData(req, res) {
         try {
            const firstName = req.query.firstName;
            const lastName = req.query.lastName;
            const _select = { __v: 0 };
            return Data.find({
                    "deceased.profile.firstName": { $regex: firstName + lastName, $options: "i" },
                    "deceased.profile.lastName": { $regex: lastName  + lastName, $options: "i" },
                })
                .sort({ _id: -1 }) // filter by _id
                .select(_select) // Do not return  __v and registrant
                .then((value) => res.status(200).json(value))
                .catch((err) => res.status(400).json(err));
        } catch (error) {
            console.error(error);
        }
    },
    async updateMovantData(req, res) {
        try {
            const _data = req.body;
            const _id = req.body.id;
            const _validators = { new: true, runValidators: true };
            const _updateData = {
                $set: {
                    movant: _data,
                    hasMoved: true,
                },
            };
            console.log("updateMovantData_body ", _data);
            return Data.findOneAndUpdate({ _id }, _updateData, _validators)
                .then((value) => {
                    if (!value) {
                        return res.status(400).json({ message: "_id not found" });
                    }
                    return res.status(200).json(value);
                })
                .catch((err) => res.status(400).json(err));
        } catch (e) {
            return res.status(400).json({ message: "Something went wrong" });
        }
    },
    async updateRegistrantData(req, res) {
        try {
            const _data = req.body;
            const _id = req.body.id;
            const _validators = { new: true, runValidators: true };
            const _updateData = {
                $set: {
                    registrant: _data,
                },
            };
            console.log("updateRegistrantData ", _data);
            return Data.findOneAndUpdate({ _id }, _updateData, _validators)
                .then((value) => {
                    if (!value) {
                        return res.status(400).json({ message: "_id not found" });
                    }
                    return res.status(200).json(value);
                })
                .catch((err) => res.status(400).json(err));
        } catch (e) {
            return res.status(400).json({ message: "Something went wrong" });
        }
    },
    async deleteBurialData(req, res) {
        try {
            const _id = req.params.id;
            Data.findOneAndRemove({ _id })
                .then((value) => {
                    if (!value) {
                        return res.status(400).json({ message: "_id not found" });
                    }
                    return res.status(200).json(value);
                })
                .catch((err) => res.status(400).json(err));
        } catch (error) {
            console.log(error);
        }
    },
};
