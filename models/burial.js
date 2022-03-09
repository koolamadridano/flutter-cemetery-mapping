const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const locations = [
    "zone-1-a",
    "zone-1-b",
    "zone-1-c",
    "zone-1-d",
    "zone-2-a",
    "zone-2-b",
    "zone-2-c",
    "zone-2-d",
    "zone-3-a",
    "zone-3-b",
    "zone-3-c",
    "zone-4-a",
    "zone-4-b",
    "zone-5-a",
    "zone-5-b",
    "zone-6-a",
    "zone-6-b",
    "zone-6-c",
    "zone-7-a",
    "zone-7-b",
    "zone-7-c",
    "zone-7-d",
];

const colors = ["black-white-gray", "black-white-gold"];

const DeceasedProfileSchema = new Schema({
    registrant: {
        profile: {
            firstName: {
                type: String,
                required: [true, "firstName is required"],
            },
            lastName: {
                type: String,
                required: [true, "lastName is required"],
            },
            middleInitial: {
                type: String,
                required: [true, "middleInitial is required"],
            },
            address: {
                type: String,
                required: [true, "address is required"],
            },
        },
        signatureUrl: {
            type: String,
            required: [true, "signatureUrl is required"],
        },
        contactNumber: {
            type: String,
            required: [true, "contactNumber is required"],
        },
        relationshipToDeceased: {
            type: String,
            required: [true, "relationshipToDeceased is required"],
        },
        dateRegistered: {
            type: Date,
            default: Date.now,
        },
    },
    deceased: {
        profile: {
            firstName: {
                type: String,
                required: [true, "firstName is required"],
            },
            lastName: {
                type: String,
                required: [true, "lastName is required"],
            },
            middleInitial: {
                type: String,
                required: [true, "middleInitial is required"],
            },
            address: {
                type: String,
                required: [true, "address is required"],
            },
        },
        tombstone: {
            lovingMessage: {
                type: String,
                required: [true, "lovingMessage is required"],
            },
            color: {
                type: String,
                enum: colors,
                required: [true, "color is required"],
            },
        },
        date: {
            birth: {
                type: Date,
                required: [true, "birth is required"],
            },
            death: {
                type: Date,
                required: [true, "death is required"],
            },
            burial: {
                type: Date,
                required: [true, "burial is required"],
            },
        },
    },
    burialLocation: {
        type: String,
        enum: locations,
        required: [true, "burialLocation is required"],
    },
    movant: {
        profile: {
            firstName: {
                type: String,
            },
            lastName: {
                type: String,
            },
            middleInitial: {
                type: String,
            },
            address: {
                type: String,
            },
        },
        signatureUrl: {
            type: String,
        },
        contactNumber: {
            type: String,
        },
        relationshipToDeceased: {
            type: String,
        },
        dateMoved: {
            type: Date,
            default: Date.now,
        },
        reason: {
            type: String,
        },
    },
    hasMoved: {
        type: Boolean,
        default: false,
    },
});

module.exports = Data = mongoose.model(
    "deceased-profiles",
    DeceasedProfileSchema
);
