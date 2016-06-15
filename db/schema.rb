# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160419142546) do

  create_table "actuator", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "actuator", ["part_id"], name: "part_id", using: :btree

  create_table "auth_provider", force: :cascade do |t|
    t.string "typ", limit: 4, null: false
  end

  create_table "auth_provider_ldap", force: :cascade do |t|
    t.string  "name",     limit: 64,                null: false
    t.string  "host",     limit: 255,               null: false
    t.integer "port",     limit: 4,   default: 636, null: false
    t.string  "protocol", limit: 10,                null: false
    t.string  "domain",   limit: 255
  end

  add_index "auth_provider_ldap", ["name"], name: "name", unique: true, using: :btree

  create_table "backplate", id: false, force: :cascade do |t|
    t.integer "part_id",                   limit: 8,                         null: false
    t.integer "dynCs",                     limit: 4
    t.integer "superbackFlatback",         limit: 4
    t.integer "mountingHoles",             limit: 4
    t.integer "mountingHoleThreadCallout", limit: 4
    t.decimal "diaA",                                precision: 6, scale: 3
    t.decimal "diaATol",                             precision: 6, scale: 3
    t.decimal "diaB",                                precision: 6, scale: 3
    t.decimal "diaBTol",                             precision: 6, scale: 3
    t.decimal "diaC",                                precision: 6, scale: 3
    t.decimal "diaCTol",                             precision: 6, scale: 3
    t.decimal "diaD",                                precision: 6, scale: 3
    t.decimal "diaDTol",                             precision: 6, scale: 3
    t.decimal "cwcDiaE",                             precision: 6, scale: 3
    t.decimal "cwcDiaETol",                          precision: 6, scale: 3
    t.decimal "boreDia",                             precision: 6, scale: 4
    t.decimal "boreDiaTol",                          precision: 6, scale: 4
    t.decimal "mountingHoleDia",                     precision: 6, scale: 3
    t.decimal "oal",                                 precision: 6, scale: 3
    t.decimal "oalTol",                              precision: 6, scale: 3
    t.decimal "hubPosF",                             precision: 6, scale: 3
    t.decimal "hubPosFTol",                          precision: 6, scale: 3
    t.decimal "ccLocPosG",                           precision: 6, scale: 3
    t.decimal "ccLocPosGTol",                        precision: 6, scale: 3
    t.decimal "leadInChmfr12Angle",                  precision: 6, scale: 1
    t.decimal "leadInChmfrLen",                      precision: 6, scale: 3
    t.integer "matL",                      limit: 4
    t.decimal "weight",                              precision: 6, scale: 1
    t.integer "diagram",                   limit: 4
  end

  add_index "backplate", ["part_id"], name: "part_id", using: :btree

  create_table "backplate_sealplate", id: false, force: :cascade do |t|
    t.integer "part_id",                     limit: 8,                            null: false
    t.integer "seal_type_id",                limit: 8
    t.string  "style_compressor_wheel",      limit: 100
    t.string  "seal_type",                   limit: 100
    t.decimal "overall_diameter",                        precision: 10, scale: 6
    t.decimal "compressor_wheel_diameter",               precision: 10, scale: 6
    t.decimal "piston_ring_diameter",                    precision: 10, scale: 6
    t.decimal "compressor_housing_diameter",             precision: 10, scale: 6
    t.string  "notes",                       limit: 500
    t.decimal "secondary_diameter",                      precision: 10, scale: 6
    t.decimal "overall_height",                          precision: 10, scale: 6
  end

  add_index "backplate_sealplate", ["part_id"], name: "part_id", using: :btree

  create_table "bearing_housing", id: false, force: :cascade do |t|
    t.integer "part_id",              limit: 8,                           null: false
    t.integer "cool_type_id",         limit: 8
    t.string  "oil_inlet",            limit: 100
    t.string  "oil_outlet",           limit: 100
    t.string  "oil",                  limit: 100
    t.string  "outlet_flange_holes",  limit: 100
    t.string  "water_ports",          limit: 100
    t.string  "design_features",      limit: 100
    t.string  "bearing_type",         limit: 100
    t.integer "waterCooled",          limit: 4
    t.decimal "cwcDia",                           precision: 6, scale: 3
    t.decimal "cwcDiaTol",                        precision: 6, scale: 3
    t.decimal "boreDiaMax",                       precision: 6, scale: 4
    t.decimal "boreDiaMin",                       precision: 6, scale: 4
    t.decimal "ceDiaA",                           precision: 6, scale: 3
    t.decimal "ceDiaATol",                        precision: 6, scale: 3
    t.decimal "teDiaD",                           precision: 6, scale: 3
    t.decimal "teDiaDTol",                        precision: 6, scale: 3
    t.decimal "ceDiaB",                           precision: 6, scale: 3
    t.decimal "ceDiaBTol",                        precision: 6, scale: 3
    t.decimal "ceDiaC",                           precision: 6, scale: 3
    t.decimal "ceDiaCTol",                        precision: 6, scale: 3
    t.decimal "teDiaE",                           precision: 6, scale: 3
    t.decimal "teDiaETol",                        precision: 6, scale: 3
    t.decimal "teDiaF",                           precision: 6, scale: 3
    t.decimal "teDiaFTol",                        precision: 6, scale: 3
    t.decimal "oal",                              precision: 6, scale: 3
    t.decimal "oalTol",                           precision: 6, scale: 3
    t.integer "oilInletThread",       limit: 4
    t.integer "oilInletFlangeThread", limit: 4
    t.integer "oilDrainThread",       limit: 4
    t.integer "oilDrainFlangeThread", limit: 4
    t.integer "coolantPortThread1",   limit: 4
    t.integer "coolantPortThread2",   limit: 4
    t.decimal "prBoreDia",                        precision: 6, scale: 3
    t.decimal "prBoreDiaTol",                     precision: 6, scale: 3
    t.decimal "leadInChmfr05Angle",               precision: 6, scale: 1
    t.decimal "leadInChmfrLen",                   precision: 6, scale: 3
    t.integer "quadrant",             limit: 4
    t.decimal "armAngle",                         precision: 6, scale: 1
    t.integer "singleDualOilFeed",    limit: 4
    t.integer "spinningBearing",      limit: 4
    t.decimal "weight",                           precision: 6, scale: 1
    t.integer "diagram",              limit: 4
  end

  add_index "bearing_housing", ["coolantPortThread1"], name: "coolantPortThread1", using: :btree
  add_index "bearing_housing", ["coolantPortThread2"], name: "coolantPortThread2", using: :btree
  add_index "bearing_housing", ["oilDrainFlangeThread"], name: "oilDrainFlangeThread", using: :btree
  add_index "bearing_housing", ["oilDrainThread"], name: "oilDrainThread", using: :btree
  add_index "bearing_housing", ["oilInletFlangeThread"], name: "oilInletFlangeThread", using: :btree
  add_index "bearing_housing", ["oilInletThread"], name: "oilInletThread", using: :btree
  add_index "bearing_housing", ["part_id"], name: "part_id", using: :btree
  add_index "bearing_housing", ["quadrant"], name: "quadrant", using: :btree
  add_index "bearing_housing", ["singleDualOilFeed"], name: "singleDualOilFeed", using: :btree
  add_index "bearing_housing", ["spinningBearing"], name: "spinningBearing", using: :btree
  add_index "bearing_housing", ["waterCooled"], name: "waterCooled", using: :btree

  create_table "bearing_spacer", id: false, force: :cascade do |t|
    t.integer "part_id",         limit: 8,                          null: false
    t.decimal "outside_dim_min",           precision: 10, scale: 6
    t.decimal "outside_dim_max",           precision: 10, scale: 6
    t.decimal "inside_dim_min",            precision: 10, scale: 6
    t.decimal "inside_dim_max",            precision: 10, scale: 6
  end

  add_index "bearing_spacer", ["part_id"], name: "part_id", using: :btree

  create_table "bolt_screw", id: false, force: :cascade do |t|
    t.integer "part_id",                limit: 8,                            null: false
    t.integer "threadCalloutA",         limit: 4
    t.decimal "threadLengthB",                       precision: 6, scale: 3
    t.integer "threadHand",             limit: 4
    t.decimal "overallLength",                       precision: 6, scale: 3
    t.decimal "headHeightC",                         precision: 6, scale: 3
    t.decimal "acrossFlatsD",                        precision: 6, scale: 3
    t.integer "headType",               limit: 4
    t.integer "driveType",              limit: 4
    t.integer "driveSize",              limit: 4
    t.decimal "headDiameter",                        precision: 6, scale: 3
    t.decimal "flangeDiameter",                      precision: 6, scale: 3
    t.integer "prevailingTorqueYn",     limit: 4
    t.integer "threadLockCompoundType", limit: 4
    t.integer "platingCoating",         limit: 4
    t.integer "propertyClassOrGrade",   limit: 4
    t.string  "specialFeatures",        limit: 4096
    t.integer "specialFeaturesOnOff",   limit: 4
    t.decimal "weight",                              precision: 6, scale: 1
    t.integer "diagram",                limit: 4
  end

  add_index "bolt_screw", ["part_id"], name: "part_id", using: :btree

  create_table "bom", force: :cascade do |t|
    t.integer "parent_part_id", limit: 8, null: false
    t.integer "child_part_id",  limit: 8, null: false
    t.integer "quantity",       limit: 4, null: false
  end

  add_index "bom", ["child_part_id"], name: "child_part_id", using: :btree
  add_index "bom", ["parent_part_id", "child_part_id"], name: "parent_part_id", unique: true, using: :btree

  create_table "bom_alt_header", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
  end

  create_table "bom_alt_item", force: :cascade do |t|
    t.integer "bom_alt_header_id", limit: 8, null: false
    t.integer "bom_id",            limit: 8, null: false
    t.integer "part_id",           limit: 8, null: false
  end

  add_index "bom_alt_item", ["bom_alt_header_id", "bom_id"], name: "bom_alt_header_id", unique: true, using: :btree
  add_index "bom_alt_item", ["bom_id"], name: "bom_id", using: :btree
  add_index "bom_alt_item", ["part_id"], name: "part_id", using: :btree

  create_table "bom_descendant", force: :cascade do |t|
    t.integer "part_bom_id",       limit: 8,  null: false
    t.integer "descendant_bom_id", limit: 8,  null: false
    t.integer "distance",          limit: 4,  null: false
    t.string  "type",              limit: 20
    t.integer "qty",               limit: 4,  null: false
  end

  add_index "bom_descendant", ["descendant_bom_id"], name: "descendant_bom_id", using: :btree
  add_index "bom_descendant", ["distance"], name: "distance", using: :btree
  add_index "bom_descendant", ["part_bom_id", "descendant_bom_id", "distance", "type", "qty"], name: "part_bom_id", unique: true, using: :btree
  add_index "bom_descendant", ["part_bom_id", "type", "distance", "descendant_bom_id"], name: "part_bom_id_2", using: :btree

  create_table "car_engine", force: :cascade do |t|
    t.string  "engine_size",      limit: 50, null: false
    t.integer "car_fuel_type_id", limit: 8
  end

  add_index "car_engine", ["car_fuel_type_id"], name: "car_fuel_type_id", using: :btree
  add_index "car_engine", ["engine_size", "car_fuel_type_id"], name: "engine_size", unique: true, using: :btree

  create_table "car_fuel_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "car_fuel_type", ["name"], name: "name", unique: true, using: :btree

  create_table "car_make", force: :cascade do |t|
    t.string  "name",      limit: 50, null: false
    t.integer "import_pk", limit: 8
  end

  add_index "car_make", ["name"], name: "name", unique: true, using: :btree

  create_table "car_model", force: :cascade do |t|
    t.string  "name",        limit: 50, null: false
    t.integer "car_make_id", limit: 8,  null: false
    t.integer "import_pk",   limit: 8
  end

  add_index "car_model", ["car_make_id"], name: "car_make_id", using: :btree
  add_index "car_model", ["name", "car_make_id"], name: "name", unique: true, using: :btree

  create_table "car_model_engine_year", force: :cascade do |t|
    t.integer "car_model_id",  limit: 8
    t.integer "car_engine_id", limit: 8
    t.integer "car_year_id",   limit: 8
    t.integer "import_pk",     limit: 8
  end

  add_index "car_model_engine_year", ["car_engine_id"], name: "car_engine_id", using: :btree
  add_index "car_model_engine_year", ["car_model_id", "car_engine_id", "car_year_id"], name: "car_model_id", unique: true, using: :btree
  add_index "car_model_engine_year", ["car_year_id"], name: "car_year_id", using: :btree

  create_table "car_year", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "car_year", ["name"], name: "name", unique: true, using: :btree

  create_table "carbon_seal", id: false, force: :cascade do |t|
    t.integer "part_id",          limit: 8,                         null: false
    t.integer "encapsulated",     limit: 4
    t.decimal "maxOd",                      precision: 6, scale: 3
    t.decimal "minOd",                      precision: 6, scale: 3
    t.decimal "maxId",                      precision: 6, scale: 3
    t.decimal "minId",                      precision: 6, scale: 3
    t.decimal "freeHeight",                 precision: 6, scale: 3
    t.decimal "compressedHeight",           precision: 6, scale: 3
    t.decimal "maxOperHeight",              precision: 6, scale: 3
    t.decimal "minOperHeight",              precision: 6, scale: 3
    t.decimal "diameterA",                  precision: 6, scale: 3
    t.decimal "diameterB",                  precision: 6, scale: 3
    t.decimal "diameterC",                  precision: 6, scale: 3
    t.decimal "diameterD",                  precision: 6, scale: 3
  end

  add_index "carbon_seal", ["part_id"], name: "part_id", using: :btree

  create_table "cartridge", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "cartridge", ["part_id"], name: "part_id", using: :btree

  create_table "changelog", force: :cascade do |t|
    t.datetime "change_date",                    null: false
    t.integer  "user_id",     limit: 8,          null: false
    t.string   "description", limit: 255,        null: false
    t.text     "data",        limit: 4294967295
  end

  add_index "changelog", ["change_date"], name: "change_date", using: :btree
  add_index "changelog", ["user_id"], name: "user_id", using: :btree

  create_table "clamp", id: false, force: :cascade do |t|
    t.integer "part_id",          limit: 8,                         null: false
    t.integer "type",             limit: 4
    t.integer "numMountingHoles", limit: 4
    t.decimal "innerRadius",                precision: 6, scale: 3
    t.decimal "holeClDistanceB",            precision: 6, scale: 3
    t.decimal "mountingHoleDiaA",           precision: 6, scale: 3
    t.decimal "thicknessC",                 precision: 6, scale: 3
    t.integer "material",         limit: 4
    t.integer "platingCoating",   limit: 4
    t.decimal "weight",                     precision: 6, scale: 1
    t.integer "diagram",          limit: 4
  end

  add_index "clamp", ["part_id"], name: "part_id", using: :btree

  create_table "compressor_cover", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "compressor_cover", ["part_id"], name: "part_id", using: :btree

  create_table "compressor_wheel", id: false, force: :cascade do |t|
    t.integer "part_id",              limit: 8,                            null: false
    t.decimal "inducer_oa",                       precision: 10, scale: 6
    t.decimal "tip_height_b",                     precision: 10, scale: 6
    t.decimal "exducer_oc",                       precision: 10, scale: 6
    t.decimal "hub_length_d",                     precision: 10, scale: 6
    t.decimal "bore_oe",                          precision: 10, scale: 6
    t.string  "trim_no_blades",       limit: 100
    t.string  "application",          limit: 100
    t.integer "rotation",             limit: 4
    t.integer "flatbackSuperback",    limit: 4
    t.integer "extendedTips",         limit: 4
    t.integer "threadedBore",         limit: 4
    t.integer "boreless",             limit: 4
    t.decimal "inducerDiameterA",                 precision: 6,  scale: 3
    t.decimal "inducerDiameterATol",              precision: 6,  scale: 3
    t.decimal "exducerDiameterB",                 precision: 6,  scale: 3
    t.decimal "exducerDiameterBTol",              precision: 6,  scale: 3
    t.decimal "tipLocation",                      precision: 6,  scale: 3
    t.decimal "tipLocationTol",                   precision: 6,  scale: 3
    t.decimal "tipHeightD",                       precision: 6,  scale: 3
    t.decimal "tipHeightDTol",                    precision: 6,  scale: 3
    t.decimal "platformHeightE",                  precision: 6,  scale: 3
    t.decimal "platformHeightTol",                precision: 6,  scale: 3
    t.decimal "maxBoreDiameter",                  precision: 6,  scale: 4
    t.decimal "minBoreDiameter",                  precision: 6,  scale: 4
    t.integer "bladeCount",           limit: 4
    t.decimal "platformThickness",                precision: 6,  scale: 3
    t.decimal "platformThicknessTol",             precision: 6,  scale: 3
    t.integer "threadCallout",        limit: 4
    t.integer "threadHand",           limit: 4
    t.decimal "platformDiameterF",                precision: 6,  scale: 3
    t.decimal "platformDiameterFTol",             precision: 6,  scale: 3
    t.decimal "overallHeightC",                   precision: 6,  scale: 2
    t.decimal "noseDiameterG",                    precision: 6,  scale: 2
    t.decimal "footDiameterH",                    precision: 6,  scale: 3
    t.decimal "bladeHeight",                      precision: 6,  scale: 1
    t.decimal "weight",                           precision: 6,  scale: 1
    t.integer "diagram",              limit: 4
  end

  add_index "compressor_wheel", ["boreless"], name: "boreless", using: :btree
  add_index "compressor_wheel", ["extendedTips"], name: "extendedTips", using: :btree
  add_index "compressor_wheel", ["flatbackSuperback"], name: "flatbackSuperback", using: :btree
  add_index "compressor_wheel", ["part_id"], name: "part_id", using: :btree
  add_index "compressor_wheel", ["rotation"], name: "rotation", using: :btree
  add_index "compressor_wheel", ["threadCallout"], name: "threadCallout", using: :btree
  add_index "compressor_wheel", ["threadHand"], name: "threadHand", using: :btree
  add_index "compressor_wheel", ["threadedBore"], name: "threadedBore", using: :btree

  create_table "cool_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "import_pk", limit: 8
  end

  add_index "cool_type", ["name"], name: "name", unique: true, using: :btree

  create_table "crit_dim", force: :cascade do |t|
    t.integer "part_type_id",          limit: 8,                                        null: false
    t.integer "seq_num",               limit: 4,                                        null: false
    t.string  "data_type",             limit: 11,                                       null: false
    t.integer "enum_id",               limit: 4
    t.string  "unit",                  limit: 7
    t.boolean "tolerance"
    t.string  "name",                  limit: 255,                                      null: false
    t.string  "json_name",             limit: 48,                                       null: false
    t.string  "idx_name",              limit: 30,                                       null: false
    t.boolean "null_allowed",                                                           null: false
    t.string  "null_display",          limit: 32
    t.decimal "min_val",                           precision: 15, scale: 6
    t.decimal "max_val",                           precision: 15, scale: 6
    t.string  "regex",                 limit: 255
    t.integer "parent_id",             limit: 8
    t.integer "length",                limit: 1
    t.integer "scale",                 limit: 1
    t.integer "is_visible_in_list",    limit: 4,                            default: 0
    t.integer "is_critical_dimension", limit: 4,                            default: 1
  end

  add_index "crit_dim", ["enum_id"], name: "enum_id", using: :btree
  add_index "crit_dim", ["idx_name"], name: "idx_name", unique: true, using: :btree
  add_index "crit_dim", ["parent_id"], name: "parent_id", using: :btree
  add_index "crit_dim", ["part_type_id"], name: "part_type_id", using: :btree

  create_table "crit_dim_enum", force: :cascade do |t|
    t.string "name", limit: 64, null: false
  end

  create_table "crit_dim_enum_val", force: :cascade do |t|
    t.integer "crit_dim_enum_id", limit: 4,  null: false
    t.string  "val",              limit: 64, null: false
  end

  add_index "crit_dim_enum_val", ["id", "crit_dim_enum_id"], name: "id", unique: true, using: :btree

  create_table "deleted_parts", id: false, force: :cascade do |t|
    t.integer  "id", limit: 8, null: false
    t.datetime "dt"
  end

  add_index "deleted_parts", ["id"], name: "id", unique: true, using: :btree

  create_table "external_systems", force: :cascade do |t|
    t.string   "url",              limit: 255
    t.text     "description",      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "sales_notes_last", limit: 4,     default: 0
    t.integer  "images_last",      limit: 4,     default: 0
  end

  create_table "fast_wearing_component", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "fast_wearing_component", ["part_id"], name: "part_id", using: :btree

  create_table "fitting", id: false, force: :cascade do |t|
    t.integer "part_id",   limit: 8,                         null: false
    t.decimal "diameterA",           precision: 6, scale: 3
    t.decimal "diameterB",           precision: 6, scale: 3
    t.decimal "diameterC",           precision: 6, scale: 3
    t.decimal "lengthD",             precision: 6, scale: 3
    t.decimal "angle",               precision: 6, scale: 1
    t.integer "thread",    limit: 4
    t.decimal "weight",              precision: 6, scale: 1
    t.integer "diagram",   limit: 4
  end

  add_index "fitting", ["part_id"], name: "part_id", using: :btree

  create_table "gasket", id: false, force: :cascade do |t|
    t.integer "part_id",            limit: 8,                            null: false
    t.integer "gasket_type_id",     limit: 8
    t.integer "type",               limit: 4
    t.integer "splitSinglePassage", limit: 4
    t.string  "shape",              limit: 4096
    t.integer "boltHoles",          limit: 4
    t.decimal "passageA",                        precision: 6, scale: 3
    t.decimal "b",                               precision: 6, scale: 2
    t.decimal "c",                               precision: 6, scale: 2
    t.decimal "d",                               precision: 6, scale: 2
    t.decimal "e",                               precision: 6, scale: 2
    t.decimal "f",                               precision: 6, scale: 2
    t.decimal "g",                               precision: 6, scale: 2
    t.decimal "h",                               precision: 6, scale: 2
    t.decimal "thickness",                       precision: 6, scale: 3
    t.integer "material",           limit: 4
    t.decimal "weight",                          precision: 6, scale: 1
    t.integer "diagram",            limit: 4
  end

  add_index "gasket", ["gasket_type_id"], name: "gasket_type_id", using: :btree
  add_index "gasket", ["material"], name: "material", using: :btree
  add_index "gasket", ["part_id"], name: "part_id", using: :btree
  add_index "gasket", ["splitSinglePassage"], name: "splitSinglePassage", using: :btree
  add_index "gasket", ["type"], name: "type", using: :btree

  create_table "gasket_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "import_pk", limit: 8
  end

  add_index "gasket_type", ["name"], name: "name", unique: true, using: :btree

  create_table "group_role", id: false, force: :cascade do |t|
    t.integer "group_id", limit: 8, null: false
    t.integer "role_id",  limit: 8, null: false
  end

  add_index "group_role", ["role_id"], name: "role_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string  "name",    limit: 100,             null: false
    t.integer "version", limit: 4,   default: 1, null: false
  end

  add_index "groups", ["name"], name: "name", unique: true, using: :btree

  create_table "heatshield", id: false, force: :cascade do |t|
    t.integer "part_id",           limit: 8,                             null: false
    t.decimal "overall_diameter",               precision: 10, scale: 6
    t.decimal "inside_diameter",                precision: 10, scale: 6
    t.decimal "inducer_diameter",               precision: 10, scale: 6
    t.string  "notes",             limit: 500
    t.decimal "diaA",                           precision: 6,  scale: 3
    t.decimal "diaATol",                        precision: 6,  scale: 3
    t.decimal "diaB",                           precision: 6,  scale: 3
    t.decimal "diaBTol",                        precision: 6,  scale: 3
    t.decimal "diaC",                           precision: 6,  scale: 3
    t.decimal "diaCTol",                        precision: 6,  scale: 3
    t.decimal "diaD",                           precision: 6,  scale: 3
    t.decimal "diaDTol",                        precision: 6,  scale: 3
    t.decimal "boreDiaE",                       precision: 6,  scale: 3
    t.decimal "boreDiaETol",                    precision: 6,  scale: 3
    t.decimal "boreHeightF",                    precision: 6,  scale: 3
    t.decimal "boreHeightFTol",                 precision: 6,  scale: 3
    t.decimal "oalG",                           precision: 6,  scale: 3
    t.decimal "oalGTol",                        precision: 6,  scale: 3
    t.integer "gauge",             limit: 4
    t.integer "matL",              limit: 4
    t.string  "specialFeatures",   limit: 4096
    t.integer "rolledLip",         limit: 4
    t.decimal "weight",                         precision: 6,  scale: 1
    t.integer "diagram",           limit: 4
    t.decimal "materialThickness",              precision: 6,  scale: 3
  end

  add_index "heatshield", ["matL"], name: "matL", using: :btree
  add_index "heatshield", ["part_id"], name: "part_id", using: :btree
  add_index "heatshield", ["rolledLip"], name: "rolledLip", using: :btree

  create_table "heatshield_shroud", id: false, force: :cascade do |t|
    t.integer "part_id",          limit: 8,                             null: false
    t.decimal "overall_diameter",              precision: 10, scale: 6
    t.decimal "inside_diameter",               precision: 10, scale: 6
    t.decimal "inducer_diameter",              precision: 10, scale: 6
    t.string  "notes",            limit: 500
    t.decimal "diaA",                          precision: 6,  scale: 3
    t.decimal "diaATol",                       precision: 6,  scale: 3
    t.decimal "diaB",                          precision: 6,  scale: 3
    t.decimal "diaBTol",                       precision: 6,  scale: 3
    t.decimal "diaC",                          precision: 6,  scale: 3
    t.decimal "diaCTol",                       precision: 6,  scale: 3
    t.decimal "diaD",                          precision: 6,  scale: 3
    t.decimal "diaDTol",                       precision: 6,  scale: 3
    t.decimal "boreDiaE",                      precision: 6,  scale: 3
    t.decimal "boreDiaETol",                   precision: 6,  scale: 3
    t.decimal "boreHeightF",                   precision: 6,  scale: 3
    t.decimal "boreHeightFTol",                precision: 6,  scale: 3
    t.decimal "oalG",                          precision: 6,  scale: 3
    t.decimal "oalGTol",                       precision: 6,  scale: 3
    t.integer "gauge",            limit: 4
    t.integer "matL",             limit: 4
    t.string  "specialFeatures",  limit: 4096
    t.integer "rolledLip",        limit: 4
    t.decimal "weight",                        precision: 6,  scale: 1
    t.integer "diagram",          limit: 4
    t.decimal "thickness",                     precision: 6,  scale: 3
  end

  add_index "heatshield_shroud", ["matL"], name: "matL", using: :btree
  add_index "heatshield_shroud", ["part_id"], name: "part_id", using: :btree
  add_index "heatshield_shroud", ["rolledLip"], name: "rolledLip", using: :btree

  create_table "i_interchange_log", force: :cascade do |t|
    t.string   "description",           limit: 250
    t.integer  "part_num_id",           limit: 8
    t.integer  "interchange_header_id", limit: 8
    t.integer  "interchange_cnt_uniq",  limit: 8
    t.datetime "date",                              null: false
  end

  create_table "interchange_header", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "description", limit: 255
    t.integer "new_part_id", limit: 8
  end

  add_index "interchange_header", ["new_part_id"], name: "new_part_id_UNIQUE", unique: true, using: :btree

  create_table "interchange_item", primary_key: "part_id", force: :cascade do |t|
    t.integer "interchange_header_id", limit: 8, null: false
  end

  add_index "interchange_item", ["interchange_header_id"], name: "interchange_header_id", using: :btree

  create_table "journal_bearing", id: false, force: :cascade do |t|
    t.integer "part_id",              limit: 8,                             null: false
    t.decimal "outside_dim_min",                   precision: 10, scale: 6
    t.decimal "outside_dim_max",                   precision: 10, scale: 6
    t.decimal "inside_dim_min",                    precision: 10, scale: 6
    t.decimal "inside_dim_max",                    precision: 10, scale: 6
    t.decimal "width",                             precision: 10, scale: 6
    t.decimal "maxOuterDiameter",                  precision: 6,  scale: 4
    t.decimal "minOuterDiameter",                  precision: 6,  scale: 4
    t.decimal "maxInnerDiameter",                  precision: 6,  scale: 4
    t.decimal "minInnerDiameter",                  precision: 6,  scale: 4
    t.integer "size",                 limit: 4
    t.decimal "length",                            precision: 6,  scale: 3
    t.decimal "lengthTol",                         precision: 6,  scale: 3
    t.integer "feedHoleCount",        limit: 4
    t.decimal "feedHoleDiameter",                  precision: 6,  scale: 3
    t.integer "freePinned",           limit: 4
    t.integer "bearingsPerCartridge", limit: 4
    t.integer "oilFeed",              limit: 4
    t.integer "rotation",             limit: 4
    t.integer "material",             limit: 4
    t.decimal "centerDiameterOd",                  precision: 6,  scale: 2
    t.integer "endConfiguration",     limit: 4
    t.integer "boreConfiguration",    limit: 4
    t.decimal "weight",                            precision: 6,  scale: 1
    t.string  "specialFeatures",      limit: 4096
    t.integer "specialFeaturesOnOff", limit: 4
    t.integer "brgSurfaces",          limit: 4
    t.integer "diagram",              limit: 4
  end

  add_index "journal_bearing", ["boreConfiguration"], name: "boreConfiguration", using: :btree
  add_index "journal_bearing", ["endConfiguration"], name: "endConfiguration", using: :btree
  add_index "journal_bearing", ["freePinned"], name: "freePinned", using: :btree
  add_index "journal_bearing", ["material"], name: "material", using: :btree
  add_index "journal_bearing", ["oilFeed"], name: "oilFeed", using: :btree
  add_index "journal_bearing", ["part_id"], name: "part_id", using: :btree
  add_index "journal_bearing", ["rotation"], name: "rotation", using: :btree
  add_index "journal_bearing", ["size"], name: "size", using: :btree
  add_index "journal_bearing", ["specialFeaturesOnOff"], name: "specialFeaturesOnOff", using: :btree

  create_table "journal_bearing_spacer", id: false, force: :cascade do |t|
    t.integer "part_id",            limit: 8,                         null: false
    t.decimal "outerDiameterA",               precision: 6, scale: 3
    t.decimal "outerDiameterATol",            precision: 6, scale: 3
    t.decimal "innerDiameterB",               precision: 6, scale: 3
    t.decimal "innerDiameterBTol",            precision: 6, scale: 3
    t.decimal "lengthC",                      precision: 6, scale: 3
    t.decimal "lengthCTol",                   precision: 6, scale: 3
    t.integer "notchesSide",        limit: 4
    t.decimal "holeDiamD",                    precision: 6, scale: 3
    t.decimal "holeDiamDTol",                 precision: 6, scale: 3
    t.integer "outerConfiguration", limit: 4
    t.integer "pressedFloating",    limit: 4
    t.decimal "weight",                       precision: 6, scale: 1
    t.integer "diagram",            limit: 4
  end

  add_index "journal_bearing_spacer", ["part_id"], name: "part_id", using: :btree

  create_table "kit", id: false, force: :cascade do |t|
    t.integer "part_id",     limit: 8, null: false
    t.integer "kit_type_id", limit: 8
  end

  add_index "kit", ["kit_type_id"], name: "kit_type_id", using: :btree
  add_index "kit", ["part_id"], name: "part_id", using: :btree

  create_table "kit_part_common_component", force: :cascade do |t|
    t.integer "kit_id",  limit: 8, null: false
    t.integer "part_id", limit: 8, null: false
    t.binary  "exclude", limit: 1, null: false
  end

  add_index "kit_part_common_component", ["kit_id", "part_id"], name: "kit_id", unique: true, using: :btree
  add_index "kit_part_common_component", ["part_id"], name: "part_id", using: :btree

  create_table "kit_type", force: :cascade do |t|
    t.string  "name",      limit: 1000, null: false
    t.integer "import_pk", limit: 8
  end

  create_table "major_component", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "major_component", ["part_id"], name: "part_id", using: :btree

  create_table "manfr", force: :cascade do |t|
    t.string  "name",            limit: 255, null: false
    t.integer "manfr_type_id",   limit: 8,   null: false
    t.integer "parent_manfr_id", limit: 8
    t.integer "import_pk",       limit: 8
  end

  add_index "manfr", ["manfr_type_id"], name: "manfr_type_id", using: :btree
  add_index "manfr", ["name"], name: "name", unique: true, using: :btree
  add_index "manfr", ["parent_manfr_id"], name: "parent_manfr_id", using: :btree

  create_table "manfr_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "manfr_type", ["name"], name: "name", unique: true, using: :btree

  create_table "mas90_std_price", id: false, force: :cascade do |t|
    t.string  "ItemNumber", limit: 50,                                        null: false
    t.decimal "StdPrice",              precision: 10, scale: 2, default: 0.0, null: false
  end

  create_table "mas90sync", force: :cascade do |t|
    t.datetime "started",                           null: false
    t.datetime "finished"
    t.integer  "to_process", limit: 8,  default: 0
    t.integer  "updated",    limit: 8,  default: 0
    t.integer  "inserted",   limit: 8,  default: 0
    t.integer  "skipped",    limit: 8,  default: 0
    t.integer  "user_id",    limit: 8
    t.string   "status",     limit: 11,             null: false
  end

  add_index "mas90sync", ["user_id"], name: "usrid_fk", using: :btree

  create_table "minor_component", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "minor_component", ["part_id"], name: "part_id", using: :btree

  create_table "misc_minor_component", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "misc_minor_component", ["part_id"], name: "part_id", using: :btree

  create_table "nozzle_ring", id: false, force: :cascade do |t|
    t.integer "part_id",            limit: 8,                            null: false
    t.decimal "unisonRingDiaA",                  precision: 6, scale: 3
    t.decimal "unisonRingDiaATol",               precision: 6, scale: 3
    t.decimal "outerDiameterB",                  precision: 6, scale: 3
    t.decimal "outerDiameterBTol",               precision: 6, scale: 3
    t.decimal "innerDiameterC",                  precision: 6, scale: 3
    t.decimal "innerDiameterCTol",               precision: 6, scale: 3
    t.integer "numVanes",           limit: 4
    t.integer "numRollers",         limit: 4
    t.string  "specialFeatures",    limit: 4096
    t.decimal "weight",                          precision: 6, scale: 1
    t.integer "numMountingHoles",   limit: 4
    t.decimal "centerHolePassageD",              precision: 6, scale: 3
    t.integer "rotation",           limit: 4
    t.integer "diagram",            limit: 4
  end

  add_index "nozzle_ring", ["part_id"], name: "part_id", using: :btree
  add_index "nozzle_ring", ["rotation"], name: "rotation", using: :btree

  create_table "nut", id: false, force: :cascade do |t|
    t.integer "part_id",              limit: 8,                            null: false
    t.integer "shaftNut",             limit: 4
    t.integer "type",                 limit: 4
    t.integer "flange",               limit: 4
    t.integer "driveType",            limit: 4
    t.integer "thread",               limit: 4
    t.integer "thdHand",              limit: 4
    t.decimal "threadLength",                      precision: 6, scale: 3
    t.decimal "oal",                               precision: 6, scale: 3
    t.decimal "oalTol",                            precision: 6, scale: 3
    t.decimal "flangeDia",                         precision: 6, scale: 3
    t.decimal "flangeDiaTol",                      precision: 6, scale: 3
    t.integer "grade",                limit: 4
    t.integer "platingCoating",       limit: 4
    t.string  "specialFeatures",      limit: 4096
    t.integer "showSpecialFeatures",  limit: 4
    t.decimal "weight",                            precision: 6, scale: 1
    t.integer "prevailingTorqueType", limit: 4
    t.integer "diagram",              limit: 4
    t.decimal "acrossFlats",                       precision: 6, scale: 3
  end

  add_index "nut", ["part_id"], name: "part_id", using: :btree

  create_table "o_ring", id: false, force: :cascade do |t|
    t.integer "part_id",                limit: 8,                            null: false
    t.decimal "innerDiaA",                           precision: 6, scale: 3
    t.decimal "innerDiaATol",                        precision: 6, scale: 3
    t.integer "crossSectionType",       limit: 4
    t.decimal "xSecDiaB",                            precision: 6, scale: 3
    t.decimal "xSecDiaBTol",                         precision: 6, scale: 3
    t.decimal "radialSectionDimSquare",              precision: 6, scale: 3
    t.decimal "radialSectionDimTol",                 precision: 6, scale: 3
    t.decimal "axialSectionDimSquare",               precision: 6, scale: 3
    t.decimal "axialSectionDimTol",                  precision: 6, scale: 3
    t.integer "matL",                   limit: 4
    t.integer "dashNo",                 limit: 4
    t.string  "specialFeatures",        limit: 4096
    t.integer "showSpecialFeatures",    limit: 4
    t.decimal "weight",                              precision: 6, scale: 1
  end

  add_index "o_ring", ["part_id"], name: "part_id", using: :btree

  create_table "oil_deflector", id: false, force: :cascade do |t|
    t.integer "part_id",          limit: 8,                         null: false
    t.decimal "outerDiameterA",             precision: 6, scale: 3
    t.decimal "innerDiameterB",             precision: 6, scale: 3
    t.integer "material",         limit: 4
    t.decimal "weight",                     precision: 6, scale: 1
    t.integer "mountingHoles",    limit: 4
    t.decimal "mountingHoleDiaC",           precision: 6, scale: 3
    t.decimal "matLThicknessD",             precision: 6, scale: 3
    t.integer "platingCoating",   limit: 4
    t.integer "diagram",          limit: 4
  end

  add_index "oil_deflector", ["part_id"], name: "part_id", using: :btree

  create_table "part", force: :cascade do |t|
    t.string  "manfr_part_num",      limit: 255,                 null: false
    t.integer "manfr_id",            limit: 8,                   null: false
    t.integer "part_type_id",        limit: 8,                   null: false
    t.string  "name",                limit: 255
    t.string  "description",         limit: 255
    t.boolean "inactive",                        default: false, null: false
    t.integer "import_pk",           limit: 8
    t.integer "version",             limit: 4,   default: 1,     null: false
    t.string  "legend_img_filename", limit: 255
  end

  add_index "part", ["id", "version"], name: "id", unique: true, using: :btree
  add_index "part", ["manfr_id"], name: "manfr_id", using: :btree
  add_index "part", ["manfr_part_num", "manfr_id"], name: "manfr_part_num", unique: true, using: :btree
  add_index "part", ["part_type_id"], name: "part_type_id", using: :btree

  create_table "part_audits", force: :cascade do |t|
    t.integer  "part_id",    limit: 4
    t.string   "action",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "part_turbo", force: :cascade do |t|
    t.integer "part_id",  limit: 8, null: false
    t.integer "turbo_id", limit: 8, null: false
  end

  add_index "part_turbo", ["part_id"], name: "part_id", using: :btree
  add_index "part_turbo", ["turbo_id"], name: "turbo_id", using: :btree

  create_table "part_turbo_type", id: false, force: :cascade do |t|
    t.integer "part_id",       limit: 8, null: false
    t.integer "turbo_type_id", limit: 8, null: false
  end

  add_index "part_turbo_type", ["turbo_type_id"], name: "turbo_type_id", using: :btree

  create_table "part_type", force: :cascade do |t|
    t.string  "name",                  limit: 255, null: false
    t.integer "parent_part_type_id",   limit: 8
    t.integer "import_pk",             limit: 8
    t.string  "magento_attribute_set", limit: 50
    t.string  "value",                 limit: 50,  null: false
    t.string  "legend_img_filename",   limit: 255
  end

  add_index "part_type", ["parent_part_type_id"], name: "parent_part_type_id", using: :btree
  add_index "part_type", ["value"], name: "value_UNIQUE", unique: true, using: :btree

  create_table "pin", id: false, force: :cascade do |t|
    t.integer "part_id",           limit: 8,                         null: false
    t.decimal "length",                      precision: 6, scale: 2
    t.decimal "outerDiameter",               precision: 6, scale: 3
    t.decimal "secondaryDiameter",           precision: 6, scale: 3
    t.integer "location",          limit: 4
    t.integer "material",          limit: 4
    t.integer "diagram",           limit: 4
  end

  add_index "pin", ["part_id"], name: "part_id", using: :btree

  create_table "piston_ring", id: false, force: :cascade do |t|
    t.integer "part_id",               limit: 8,                          null: false
    t.decimal "outside_dim_min",                 precision: 10, scale: 6
    t.decimal "outside_dim_max",                 precision: 10, scale: 6
    t.decimal "width_min",                       precision: 10, scale: 6
    t.decimal "width_max",                       precision: 10, scale: 6
    t.decimal "i_gap_min",                       precision: 10, scale: 6
    t.decimal "i_gap_max",                       precision: 10, scale: 6
    t.decimal "installedDiameterA",              precision: 6,  scale: 3
    t.decimal "gapBInstalledDiameter",           precision: 6,  scale: 3
    t.decimal "thicknessC",                      precision: 6,  scale: 3
    t.decimal "thicknessCTol",                   precision: 6,  scale: 3
    t.decimal "widthD",                          precision: 6,  scale: 4
    t.decimal "widthDUpperTol",                  precision: 6,  scale: 4
    t.decimal "widthDLowerTol",                  precision: 6,  scale: 4
    t.integer "material",              limit: 4
    t.integer "type",                  limit: 4
    t.decimal "weight",                          precision: 6,  scale: 1
    t.integer "diagram",               limit: 4
  end

  add_index "piston_ring", ["material"], name: "material", using: :btree
  add_index "piston_ring", ["part_id"], name: "part_id", using: :btree
  add_index "piston_ring", ["type"], name: "type", using: :btree

  create_table "plug", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "plug", ["part_id"], name: "part_id", using: :btree

  create_table "product_image", force: :cascade do |t|
    t.integer "part_id",  limit: 8,   null: false
    t.string  "filename", limit: 255
  end

  add_index "product_image", ["filename"], name: "filename", unique: true, using: :btree
  add_index "product_image", ["part_id"], name: "part_id", using: :btree

  create_table "products_images_audits", force: :cascade do |t|
    t.string   "action",     limit: 255
    t.integer  "image_id",   limit: 4
    t.integer  "part_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "retaining_ring", id: false, force: :cascade do |t|
    t.integer "part_id",                  limit: 8,                            null: false
    t.string  "referenceNumber",          limit: 4096
    t.integer "internalExternal",         limit: 4
    t.integer "ringType",                 limit: 4
    t.integer "taperedConstantSection",   limit: 4
    t.integer "axiallyRadiallyAssembled", limit: 4
    t.integer "selfLocking",              limit: 4
    t.integer "beveled",                  limit: 4
    t.integer "bowed",                    limit: 4
    t.decimal "freeDiaA",                              precision: 6, scale: 3
    t.decimal "freeDiaALowerTol",                      precision: 6, scale: 3
    t.decimal "freeDiaAUpperTol",                      precision: 6, scale: 3
    t.decimal "thicknessB",                            precision: 6, scale: 3
    t.decimal "thicknessBTol",                         precision: 6, scale: 3
    t.decimal "holeDiaC",                              precision: 6, scale: 3
    t.integer "numberOfProngs",           limit: 4
    t.decimal "housingBoreDiaE",                       precision: 6, scale: 3
    t.decimal "shaftDiaD",                             precision: 6, scale: 3
    t.decimal "grooveDia",                             precision: 6, scale: 3
    t.decimal "grooveDiaUpperTol",                     precision: 6, scale: 3
    t.decimal "grooveDiaLowerTol",                     precision: 6, scale: 3
    t.decimal "grooveWidth",                           precision: 6, scale: 3
    t.decimal "grooveWidthUpperTol",                   precision: 6, scale: 3
    t.decimal "grooveWidthLowerTol",                   precision: 6, scale: 3
    t.integer "material",                 limit: 4
    t.integer "finishPlating",            limit: 4
    t.decimal "weight",                                precision: 6, scale: 1
    t.integer "diagram",                  limit: 4
  end

  add_index "retaining_ring", ["part_id"], name: "part_id", using: :btree

  create_table "role", force: :cascade do |t|
    t.string "name",    limit: 100, null: false
    t.string "display", limit: 100, null: false
  end

  add_index "role", ["name"], name: "name", unique: true, using: :btree

  create_table "sales_note", force: :cascade do |t|
    t.datetime "create_date",                    null: false
    t.datetime "write_date",                     null: false
    t.integer  "create_uid",  limit: 8,          null: false
    t.integer  "write_uid",   limit: 8,          null: false
    t.string   "state",       limit: 15,         null: false
    t.text     "comment",     limit: 4294967295, null: false
  end

  add_index "sales_note", ["create_uid"], name: "fk_sales_note_user_create_uid_idx", using: :btree
  add_index "sales_note", ["write_uid"], name: "fk_sales_note_user_write_uid_idx", using: :btree

  create_table "sales_note_attachment", force: :cascade do |t|
    t.datetime "create_date",              null: false
    t.datetime "write_date",               null: false
    t.integer  "create_uid",    limit: 8,  null: false
    t.integer  "write_uid",     limit: 8,  null: false
    t.integer  "sales_note_id", limit: 8,  null: false
    t.string   "filename",      limit: 45, null: false
  end

  add_index "sales_note_attachment", ["create_uid"], name: "fk_sales_note_attachment_user_create_uid_idx", using: :btree
  add_index "sales_note_attachment", ["sales_note_id", "filename"], name: "sales_note_id_filename", unique: true, using: :btree
  add_index "sales_note_attachment", ["sales_note_id"], name: "sales_note_attachment_sales_note_sales_note_id_idx", using: :btree
  add_index "sales_note_attachment", ["write_uid"], name: "fk_sales_note_attachment_user_write_uid_idx", using: :btree

  create_table "sales_note_part", id: false, force: :cascade do |t|
    t.integer  "sales_note_id", limit: 8, null: false
    t.integer  "part_id",       limit: 8, null: false
    t.datetime "create_date",             null: false
    t.datetime "write_date",              null: false
    t.integer  "create_uid",    limit: 8, null: false
    t.integer  "write_uid",     limit: 8, null: false
    t.boolean  "primary_part",            null: false
  end

  add_index "sales_note_part", ["create_uid"], name: "sales_note_part_user_create_uid_idx", using: :btree
  add_index "sales_note_part", ["part_id"], name: "sales_note_part_part_part_id_idx", using: :btree
  add_index "sales_note_part", ["write_uid"], name: "sales_note_part_user_write_uid_idx", using: :btree

  create_table "sales_notes_audits", force: :cascade do |t|
    t.string   "action",        limit: 255
    t.integer  "sales_note_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "old_state",     limit: 255
    t.string   "state",         limit: 255
  end

  create_table "seal_plate", id: false, force: :cascade do |t|
    t.integer "part_id",                  limit: 8,                         null: false
    t.decimal "diaA",                               precision: 6, scale: 3
    t.decimal "diaATol",                            precision: 6, scale: 3
    t.decimal "diaB",                               precision: 6, scale: 3
    t.decimal "diaBTol",                            precision: 6, scale: 3
    t.decimal "diaC",                               precision: 6, scale: 3
    t.decimal "diaCTol",                            precision: 6, scale: 3
    t.decimal "diaD",                               precision: 6, scale: 3
    t.decimal "diaDTol",                            precision: 6, scale: 3
    t.decimal "oalE",                               precision: 6, scale: 3
    t.decimal "oalETol",                            precision: 6, scale: 3
    t.decimal "boreDia",                            precision: 6, scale: 3
    t.decimal "boreDiaTol",                         precision: 6, scale: 3
    t.decimal "prBoreDia",                          precision: 6, scale: 4
    t.decimal "prBoreDiaTol",                       precision: 6, scale: 4
    t.decimal "cwcDia",                             precision: 6, scale: 3
    t.decimal "cwcDiaTol",                          precision: 6, scale: 3
    t.decimal "oRingGrooveDia",                     precision: 6, scale: 3
    t.decimal "oRingGrooveDiaTol",                  precision: 6, scale: 3
    t.decimal "oRingGrooveWidth",                   precision: 6, scale: 3
    t.decimal "oRingGrooveWidthTol",                precision: 6, scale: 3
    t.integer "mountingHoles",            limit: 4
    t.decimal "mountingHoleDia",                    precision: 6, scale: 3
    t.decimal "hubPosF",                            precision: 6, scale: 3
    t.decimal "hubPosFTol",                         precision: 6, scale: 3
    t.decimal "leadInChmfr05Angle",                 precision: 6, scale: 1
    t.decimal "leadInChmfrLen",                     precision: 6, scale: 3
    t.decimal "clampedWidthG",                      precision: 6, scale: 3
    t.decimal "clampedWidthGTol",                   precision: 6, scale: 3
    t.integer "superbackFlatbackSpecial", limit: 4
    t.integer "dynamicCarbonSeal",        limit: 4
    t.integer "matL",                     limit: 4
    t.decimal "weight",                             precision: 6, scale: 1
    t.integer "diagram",                  limit: 4
  end

  add_index "seal_plate", ["part_id"], name: "part_id", using: :btree

  create_table "seal_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "import_pk", limit: 8,   null: false
  end

  add_index "seal_type", ["name"], name: "name", unique: true, using: :btree

  create_table "spring", id: false, force: :cascade do |t|
    t.integer "part_id",       limit: 8,                         null: false
    t.decimal "outerDiameter",           precision: 6, scale: 3
    t.decimal "overallLength",           precision: 6, scale: 2
    t.integer "type",          limit: 4
    t.integer "material",      limit: 4
    t.integer "diagram",       limit: 4
  end

  add_index "spring", ["part_id"], name: "part_id", using: :btree

  create_table "standard_bearing_spacer", id: false, force: :cascade do |t|
    t.integer "standard_part_id",  limit: 8, null: false
    t.integer "oversized_part_id", limit: 8, null: false
  end

  add_index "standard_bearing_spacer", ["oversized_part_id"], name: "oversized_part_id", using: :btree

  create_table "standard_journal_bearing", id: false, force: :cascade do |t|
    t.integer "standard_part_id",  limit: 8, null: false
    t.integer "oversized_part_id", limit: 8, null: false
  end

  add_index "standard_journal_bearing", ["oversized_part_id"], name: "oversized_part_id", using: :btree

  create_table "standard_oversize_part", id: false, force: :cascade do |t|
    t.integer "standard_part_id", limit: 8, null: false
    t.integer "oversize_part_id", limit: 8, null: false
  end

  add_index "standard_oversize_part", ["oversize_part_id"], name: "standard_oversize_part_oversized_part_id_idx", using: :btree

  create_table "test_ii", id: false, force: :cascade do |t|
    t.integer "p_id",                  limit: 8, default: 0, null: false
    t.integer "interchange_header_id", limit: 8
    t.integer "pi_id",                 limit: 8, default: 0
    t.integer "part_id",               limit: 8
  end

  create_table "test_pi", id: false, force: :cascade do |t|
    t.integer "id",                    limit: 8, default: 0, null: false
    t.integer "interchange_header_id", limit: 8
    t.integer "part_id",               limit: 8
    t.integer "part_id_comb",          limit: 8
  end

  create_table "test_vmagmi_service_kits", id: false, force: :cascade do |t|
    t.integer "sku",             limit: 8,   default: 0, null: false
    t.integer "kitSku",          limit: 8,   default: 0, null: false
    t.string  "kitPartNumber",   limit: 255,             null: false
    t.string  "description",     limit: 255
    t.integer "tiKitSku",        limit: 8,   default: 0
    t.string  "tiKitPartNumber", limit: 255
  end

  create_table "thrust_bearing", id: false, force: :cascade do |t|
    t.integer "part_id",            limit: 8,                         null: false
    t.decimal "maxThicknessA",                precision: 6, scale: 4
    t.decimal "minThicknessA",                precision: 6, scale: 4
    t.decimal "odB",                          precision: 6, scale: 3
    t.decimal "odBTol",                       precision: 6, scale: 3
    t.decimal "idC",                          precision: 6, scale: 3
    t.decimal "idCTol",                       precision: 6, scale: 3
    t.decimal "teRampDiaD",                   precision: 6, scale: 3
    t.decimal "teRampDiaDTol",                precision: 6, scale: 3
    t.decimal "ceRampDiaE",                   precision: 6, scale: 3
    t.decimal "ceRampDiaETol",                precision: 6, scale: 3
    t.integer "numRampsTe",         limit: 4
    t.integer "numRampsCe",         limit: 4
    t.decimal "teRampDrainDiaF",              precision: 6, scale: 3
    t.decimal "teRampDrainDiaFTol",           precision: 6, scale: 3
    t.decimal "ceRampDrainDiaG",              precision: 6, scale: 3
    t.decimal "ceRampDrainDiaGTol",           precision: 6, scale: 3
    t.integer "rotation",           limit: 4
    t.integer "numLocatingHoles",   limit: 4
    t.decimal "diaLocatingHoles",             precision: 6, scale: 3
    t.integer "degreesOfRamps",     limit: 4
    t.integer "material",           limit: 4
    t.decimal "weight",                       precision: 6, scale: 1
    t.integer "diagram",            limit: 4
  end

  add_index "thrust_bearing", ["part_id"], name: "part_id", using: :btree

  create_table "thrust_collar", id: false, force: :cascade do |t|
    t.integer "part_id",                       limit: 8,                         null: false
    t.decimal "aLengthAcrossThrustBearing",              precision: 6, scale: 4
    t.decimal "aLengthAcrossThrustBearingTol",           precision: 6, scale: 4
    t.decimal "bOal",                                    precision: 6, scale: 4
    t.decimal "bOalTol",                                 precision: 6, scale: 4
    t.decimal "cteThrustDia",                            precision: 6, scale: 3
    t.decimal "cteThrustDiaTol",                         precision: 6, scale: 3
    t.decimal "dceThrustDia",                            precision: 6, scale: 3
    t.decimal "dceThrustDiaTol",                         precision: 6, scale: 3
    t.decimal "eBoreDia",                                precision: 6, scale: 4
    t.decimal "eBoreDiaTol",                             precision: 6, scale: 4
    t.decimal "fPistonRingGroove1MajorDia",              precision: 6, scale: 3
    t.decimal "fPistonRingGroove1MajorDiaTol",           precision: 6, scale: 3
    t.decimal "gPistonRingGroove1MinorDia",              precision: 6, scale: 3
    t.decimal "gPistonRingGroove1MinorDiaTol",           precision: 6, scale: 3
    t.decimal "hPistonRingGroove1Width",                 precision: 6, scale: 3
    t.decimal "hPistonRingGroove1WidthTol",              precision: 6, scale: 3
    t.decimal "iceFlingerDia",                           precision: 6, scale: 3
    t.decimal "jteFlingerDia",                           precision: 6, scale: 3
    t.decimal "kPistonRingGroove2MajorDia",              precision: 6, scale: 3
    t.decimal "kPistonRingGroove2MajorDiaTol",           precision: 6, scale: 3
    t.decimal "lPistonRingGroove2MinorDia",              precision: 6, scale: 3
    t.decimal "lPistonRingGroove2MinorDiaTol",           precision: 6, scale: 3
    t.decimal "mPistonRingGroove2Width",                 precision: 6, scale: 3
    t.decimal "mPistonRingGroove2WidthTol",              precision: 6, scale: 3
    t.integer "numFlingerHolesCeRow",          limit: 4
    t.decimal "diaFlingerHolesCeRow",                    precision: 6, scale: 3
    t.integer "numFlingerHolesTeRow",          limit: 4
    t.decimal "diaFlingerHolesTeRow",                    precision: 6, scale: 3
    t.integer "material",                      limit: 4
    t.decimal "weight",                                  precision: 6, scale: 1
    t.integer "diagram",                       limit: 4
  end

  add_index "thrust_collar", ["part_id"], name: "part_id", using: :btree

  create_table "thrust_part", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "thrust_part", ["part_id"], name: "part_id", using: :btree

  create_table "thrust_spacer", id: false, force: :cascade do |t|
    t.integer "part_id",                       limit: 8,                         null: false
    t.decimal "aOal",                                    precision: 6, scale: 4
    t.decimal "aOalTol",                                 precision: 6, scale: 4
    t.decimal "bThrustDia",                              precision: 6, scale: 3
    t.decimal "bThrustDiaTol",                           precision: 6, scale: 3
    t.decimal "cBoreDia",                                precision: 6, scale: 4
    t.decimal "cBoreDiaTol",                             precision: 6, scale: 4
    t.decimal "dPistonRingGroove1MajorDia",              precision: 6, scale: 3
    t.decimal "dPistonRingGroove1MajorDiaTol",           precision: 6, scale: 3
    t.decimal "ePistonRingGroove1MinorDia",              precision: 6, scale: 3
    t.decimal "ePistonRingGroove1MinorDiaTol",           precision: 6, scale: 3
    t.decimal "fPistonRingGroove1Width",                 precision: 6, scale: 3
    t.decimal "fPistonRingGroove1WidthTol",              precision: 6, scale: 3
    t.decimal "gPistonRingGroove2MajorDia",              precision: 6, scale: 3
    t.decimal "gPistonRingGroove2MajorDiaTol",           precision: 6, scale: 3
    t.decimal "hPistonRingGroove2MinorDia",              precision: 6, scale: 3
    t.decimal "hPistonRingGroove2MinorDiaTol",           precision: 6, scale: 3
    t.decimal "iPistonRingGroove2Width",                 precision: 6, scale: 3
    t.decimal "iPistonRingGroove2WidthTol",              precision: 6, scale: 3
    t.decimal "jceFlingerDia",                           precision: 6, scale: 3
    t.decimal "kteFlingerDia",                           precision: 6, scale: 3
    t.integer "numFlingerHolesCeRow",          limit: 4
    t.decimal "diaFlingerHolesCeRow",                    precision: 6, scale: 3
    t.integer "numFlingerHolesTeRow",          limit: 4
    t.decimal "diaFlingerHolesTeRow",                    precision: 6, scale: 3
    t.integer "material",                      limit: 4
    t.decimal "weight",                                  precision: 6, scale: 1
    t.integer "diagram",                       limit: 4
  end

  add_index "thrust_spacer", ["part_id"], name: "part_id", using: :btree

  create_table "thrust_washer", id: false, force: :cascade do |t|
    t.integer "part_id",      limit: 8,                         null: false
    t.decimal "thickness",              precision: 6, scale: 4
    t.decimal "thicknessTol",           precision: 6, scale: 4
    t.decimal "od",                     precision: 6, scale: 3
    t.decimal "odTol",                  precision: 6, scale: 3
    t.decimal "id_",                    precision: 6, scale: 3
    t.decimal "idTol",                  precision: 6, scale: 3
    t.integer "material",     limit: 4
    t.decimal "weight",                 precision: 6, scale: 1
  end

  add_index "thrust_washer", ["part_id"], name: "part_id", using: :btree

  create_table "turbine_housing", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "turbine_housing", ["part_id"], name: "part_id", using: :btree

  create_table "turbine_wheel", id: false, force: :cascade do |t|
    t.integer "part_id",                           limit: 8,                            null: false
    t.decimal "exduce_oa",                                     precision: 10, scale: 6
    t.decimal "tip_height_b",                                  precision: 10, scale: 6
    t.decimal "inducer_oc",                                    precision: 10, scale: 6
    t.decimal "journal_od",                                    precision: 10, scale: 6
    t.decimal "stem_oe",                                       precision: 10, scale: 6
    t.string  "trim_no_blades",                    limit: 100
    t.string  "shaft_thread_f",                    limit: 100
    t.decimal "inducerDiaA",                                   precision: 6,  scale: 3
    t.decimal "inducerDiaATol",                                precision: 6,  scale: 3
    t.decimal "exducerDiaB",                                   precision: 6,  scale: 3
    t.decimal "exducerDiaBTol",                                precision: 6,  scale: 3
    t.decimal "tipHeightC",                                    precision: 6,  scale: 3
    t.decimal "tipHeightCTol",                                 precision: 6,  scale: 3
    t.decimal "maxJournalDiameterD",                           precision: 6,  scale: 4
    t.decimal "minJournalDiameterD",                           precision: 6,  scale: 4
    t.decimal "minStemDiameterE",                              precision: 6,  scale: 4
    t.decimal "maxStemDiameterE",                              precision: 6,  scale: 4
    t.decimal "stemLengthF",                                   precision: 6,  scale: 2
    t.decimal "stemLengthFTol",                                precision: 6,  scale: 2
    t.decimal "platformHeightH",                               precision: 6,  scale: 2
    t.decimal "bladeHeight",                                   precision: 6,  scale: 2
    t.decimal "threadLengthG",                                 precision: 6,  scale: 2
    t.integer "thread",                            limit: 4
    t.integer "threadHand",                        limit: 4
    t.decimal "pistonRingGrooveMajorDiaI",                     precision: 6,  scale: 3
    t.decimal "pistonRingGrooveMajorDiaITol",                  precision: 6,  scale: 3
    t.decimal "pistonRingGrooveMinorDiaJ",                     precision: 6,  scale: 3
    t.decimal "pistonRingGrooveMinorDiaJTol",                  precision: 6,  scale: 3
    t.decimal "pistonRingGrooveWidthK",                        precision: 6,  scale: 3
    t.decimal "pistonRingGrooveWidthKTol",                     precision: 6,  scale: 3
    t.decimal "the2ndPistonRingGrooveMajorDia",                precision: 6,  scale: 3
    t.decimal "the2ndPistonRingGrooveMajorDiaTol",             precision: 6,  scale: 3
    t.decimal "the2ndPistonRingGrooveMinorDia",                precision: 6,  scale: 3
    t.decimal "the2ndPistonRingGrooveMinorDiaTol",             precision: 6,  scale: 3
    t.decimal "the2ndPistonRingGrooveWidth",                   precision: 6,  scale: 3
    t.decimal "the2ndPistonRingGrooveWidthTol",                precision: 6,  scale: 3
    t.integer "rotation",                          limit: 4
    t.integer "bladeCount",                        limit: 4
    t.integer "shroudType",                        limit: 4
    t.integer "journalType",                       limit: 4
    t.integer "extendedTips",                      limit: 4
    t.decimal "weight",                                        precision: 6,  scale: 1
    t.integer "diagram",                           limit: 4
  end

  add_index "turbine_wheel", ["extendedTips"], name: "extendedTips", using: :btree
  add_index "turbine_wheel", ["journalType"], name: "journalType", using: :btree
  add_index "turbine_wheel", ["part_id"], name: "part_id", using: :btree
  add_index "turbine_wheel", ["rotation"], name: "rotation", using: :btree
  add_index "turbine_wheel", ["shroudType"], name: "shroudType", using: :btree
  add_index "turbine_wheel", ["thread"], name: "thread", using: :btree
  add_index "turbine_wheel", ["threadHand"], name: "threadHand", using: :btree

  create_table "turbo", id: false, force: :cascade do |t|
    t.integer "part_id",        limit: 8, null: false
    t.integer "turbo_model_id", limit: 8
    t.integer "cool_type_id",   limit: 8
  end

  add_index "turbo", ["cool_type_id"], name: "cool_type_id", using: :btree
  add_index "turbo", ["part_id"], name: "part_id", using: :btree
  add_index "turbo", ["turbo_model_id"], name: "turbo_model_id", using: :btree

  create_table "turbo_car_model_engine_year", id: false, force: :cascade do |t|
    t.integer "part_id",                  limit: 8, null: false
    t.integer "car_model_engine_year_id", limit: 8, null: false
    t.integer "import_pk",                limit: 8
  end

  add_index "turbo_car_model_engine_year", ["car_model_engine_year_id"], name: "car_model_engine_year_id", using: :btree

  create_table "turbo_model", force: :cascade do |t|
    t.string  "name",          limit: 255
    t.integer "turbo_type_id", limit: 8
    t.integer "import_pk",     limit: 8
  end

  add_index "turbo_model", ["turbo_type_id"], name: "turbo_type_id", using: :btree

  create_table "turbo_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "manfr_id",  limit: 8,   null: false
    t.integer "import_pk", limit: 8
  end

  add_index "turbo_type", ["manfr_id"], name: "manfr_id", using: :btree
  add_index "turbo_type", ["name", "manfr_id"], name: "name", unique: true, using: :btree

  create_table "user", force: :cascade do |t|
    t.string  "name",                 limit: 100,                null: false
    t.string  "email",                limit: 255,                null: false
    t.string  "password",             limit: 100,                null: false
    t.string  "password_reset_token", limit: 36
    t.boolean "enabled",                          default: true, null: false
    t.integer "auth_provider_id",     limit: 8
    t.string  "username",             limit: 255,                null: false
  end

  add_index "user", ["auth_provider_id"], name: "fk_authp", using: :btree
  add_index "user", ["email"], name: "email", unique: true, using: :btree
  add_index "user", ["password_reset_token"], name: "password_reset_token", unique: true, using: :btree
  add_index "user", ["username"], name: "username", unique: true, using: :btree

  create_table "user_group", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 8, null: false
    t.integer "group_id", limit: 8, null: false
  end

  add_index "user_group", ["group_id"], name: "group_id", using: :btree

  create_table "vapp", id: false, force: :cascade do |t|
    t.integer "part_id",   limit: 8,   default: 0, null: false
    t.string  "car_make",  limit: 50
    t.string  "car_year",  limit: 255
    t.string  "car_model", limit: 50
  end

  create_table "vbalt", id: false, force: :cascade do |t|
    t.integer "bom_id",              limit: 8,               null: false
    t.integer "child_part_id",       limit: 8,               null: false
    t.integer "bom_alt_header_id",   limit: 8,               null: false
    t.string  "alt_header_name",     limit: 255
    t.string  "alt_header_desc",     limit: 255
    t.integer "alt_part_id",         limit: 8,               null: false
    t.string  "alt_part_type",       limit: 255,             null: false
    t.string  "alt_part_number",     limit: 255,             null: false
    t.string  "alt_manufacturer",    limit: 255,             null: false
    t.integer "alt_manufacturer_id", limit: 8,   default: 0, null: false
  end

  create_table "vbom", id: false, force: :cascade do |t|
    t.integer "bom_id",         limit: 8,   default: 0, null: false
    t.integer "p_part_id",      limit: 8,   default: 0, null: false
    t.string  "p_part_type",    limit: 255,             null: false
    t.string  "p_part_number",  limit: 255,             null: false
    t.string  "p_manufacturer", limit: 255,             null: false
    t.integer "c_part_id",      limit: 8,   default: 0, null: false
    t.string  "c_part_type",    limit: 255,             null: false
    t.string  "c_part_number",  limit: 255,             null: false
    t.string  "c_manufacturer", limit: 255,             null: false
  end

  create_table "vbom_ancestor", id: false, force: :cascade do |t|
    t.integer "id",               limit: 8,  default: 0, null: false
    t.integer "part_id",          limit: 8,              null: false
    t.integer "ancestor_part_id", limit: 8,              null: false
    t.integer "distance",         limit: 4,              null: false
    t.string  "type",             limit: 20
  end

  create_table "vbom_descendant", id: false, force: :cascade do |t|
    t.integer "id",                 limit: 8,  default: 0, null: false
    t.integer "part_bom_id",        limit: 8,              null: false
    t.integer "descendant_bom_id",  limit: 8,              null: false
    t.integer "distance",           limit: 4,              null: false
    t.string  "type",               limit: 20
    t.integer "qty",                limit: 4,              null: false
    t.integer "part_id_ancestor",   limit: 8,              null: false
    t.integer "part_id_descendant", limit: 8,              null: false
  end

  create_table "vbom_descendant_direct", id: false, force: :cascade do |t|
    t.integer "id",                 limit: 8,  default: 0, null: false
    t.integer "part_bom_id",        limit: 8,              null: false
    t.integer "descendant_bom_id",  limit: 8,              null: false
    t.integer "distance",           limit: 4,              null: false
    t.string  "type",               limit: 20
    t.integer "qty",                limit: 4,              null: false
    t.integer "part_id_ancestor",   limit: 8,              null: false
    t.integer "part_id_descendant", limit: 8,              null: false
  end

  create_table "vint", id: false, force: :cascade do |t|
    t.integer "interchange_header_id", limit: 8,               null: false
    t.integer "part_id",               limit: 8,   default: 0, null: false
    t.string  "part_type",             limit: 255,             null: false
    t.string  "part_number",           limit: 255,             null: false
    t.string  "manufacturer",          limit: 255,             null: false
    t.integer "i_part_id",             limit: 8,   default: 0
    t.string  "i_part_type",           limit: 255,             null: false
    t.string  "i_part_number",         limit: 255
    t.string  "i_manufacturer",        limit: 255
  end

  create_table "vint_ti", id: false, force: :cascade do |t|
    t.integer "interchange_header_id", limit: 8,             null: false
    t.integer "part_id",               limit: 8, default: 0, null: false
    t.integer "ti_part_id",            limit: 8, default: 0
  end

  create_table "vkp", id: false, force: :cascade do |t|
    t.integer "kit_id",  limit: 8, null: false
    t.integer "part_id", limit: 8, null: false
    t.binary  "exclude", limit: 1, null: false
  end

  create_table "vmagmi_bom", id: false, force: :cascade do |t|
    t.integer "ancestor_sku",     limit: 8,              null: false
    t.integer "descendant_sku",   limit: 8,              null: false
    t.integer "quantity",         limit: 4,              null: false
    t.integer "distance",         limit: 4,              null: false
    t.string  "type",             limit: 20
    t.string  "part_type_parent", limit: 50
    t.integer "has_bom",          limit: 4,  default: 0, null: false
    t.integer "alt_sku",          limit: 8
    t.integer "alt_mfr_id",       limit: 8,  default: 0
    t.integer "int_sku",          limit: 8,  default: 0
  end

  create_table "vmagmi_service_kits", id: false, force: :cascade do |t|
    t.integer "sku",             limit: 8,   default: 0, null: false
    t.integer "kitSku",          limit: 8,   default: 0, null: false
    t.string  "kitPartNumber",   limit: 255,             null: false
    t.string  "description",     limit: 255
    t.integer "tiKitSku",        limit: 8,   default: 0
    t.string  "tiKitPartNumber", limit: 255
  end

  create_table "vmagmi_sop", id: false, force: :cascade do |t|
    t.integer "part_id",            limit: 8,   default: 0, null: false
    t.integer "standard_part_sku",  limit: 8,   default: 0, null: false
    t.string  "oversize_part_skus", limit: 341
  end

  create_table "vmagmi_ti_chra", id: false, force: :cascade do |t|
    t.integer "id",          limit: 8, default: 0,  null: false
    t.string  "has_ti_chra", limit: 3, default: "", null: false
  end

  create_table "vpart_turbo", id: false, force: :cascade do |t|
    t.integer "part_id",  limit: 8, default: 0, null: false
    t.integer "turbo_id", limit: 8, default: 0, null: false
  end

  create_table "vpart_turbotype_kits", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, default: 0, null: false
    t.integer "kit_id",  limit: 8, default: 0, null: false
  end

  create_table "vparts", id: false, force: :cascade do |t|
    t.integer "part_id",      limit: 8,   default: 0, null: false
    t.string  "part_type",    limit: 255,             null: false
    t.string  "part_number",  limit: 255,             null: false
    t.string  "manufacturer", limit: 255,             null: false
  end

  create_table "vtapp", id: false, force: :cascade do |t|
    t.integer "part_id",   limit: 8,   null: false
    t.string  "car_make",  limit: 50
    t.string  "car_year",  limit: 255
    t.string  "car_model", limit: 50
  end

  create_table "vwhere_used", id: false, force: :cascade do |t|
    t.integer "principal_id",      limit: 8,   default: 0, null: false
    t.string  "principal_type",    limit: 255,             null: false
    t.integer "sku",               limit: 8,   default: 0, null: false
    t.string  "manufacturer",      limit: 255,             null: false
    t.string  "part_number",       limit: 255,             null: false
    t.integer "ti_sku",            limit: 8,   default: 0
    t.string  "ti_part_number",    limit: 255
    t.string  "part_type",         limit: 255,             null: false
    t.string  "turbo_type",        limit: 255
    t.string  "turbo_part_number", limit: 255
  end

  create_table "washer", id: false, force: :cascade do |t|
    t.integer "part_id",        limit: 8,                         null: false
    t.decimal "od",                       precision: 6, scale: 3
    t.decimal "odTol",                    precision: 6, scale: 3
    t.decimal "id_",                      precision: 6, scale: 3
    t.decimal "idTol",                    precision: 6, scale: 3
    t.decimal "thickness",                precision: 6, scale: 3
    t.decimal "thicknessTol",             precision: 6, scale: 3
    t.integer "type",           limit: 4
    t.integer "material",       limit: 4
    t.integer "platingCoating", limit: 4
    t.decimal "weight",                   precision: 6, scale: 1
    t.integer "diagram",        limit: 4
  end

  add_index "washer", ["part_id"], name: "part_id", using: :btree

  add_foreign_key "auth_provider_ldap", "auth_provider", column: "id", name: "auth_provider_ldap_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "backplate_sealplate", "part", name: "backplate_sealplate_ibfk_1"
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "coolantPortThread1", name: "bearing_housing_ibfk_7", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "coolantPortThread2", name: "bearing_housing_ibfk_8", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "oilDrainFlangeThread", name: "bearing_housing_ibfk_6", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "oilDrainThread", name: "bearing_housing_ibfk_5", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "oilInletFlangeThread", name: "bearing_housing_ibfk_4", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "oilInletThread", name: "bearing_housing_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "quadrant", name: "bearing_housing_ibfk_9", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "singleDualOilFeed", name: "bearing_housing_ibfk_10", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "spinningBearing", name: "bearing_housing_ibfk_11", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "crit_dim_enum_val", column: "waterCooled", name: "bearing_housing_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "bearing_housing", "part", name: "bearing_housing_ibfk_1"
  add_foreign_key "bearing_spacer", "part", name: "bearing_spacer_ibfk_1"
  add_foreign_key "bom", "part", column: "child_part_id", name: "bom_ibfk_2"
  add_foreign_key "bom", "part", column: "parent_part_id", name: "bom_ibfk_1"
  add_foreign_key "bom_alt_item", "bom", name: "bom_alt_item_ibfk_2"
  add_foreign_key "bom_alt_item", "bom_alt_header", name: "bom_alt_item_ibfk_1"
  add_foreign_key "bom_alt_item", "part", name: "bom_alt_item_ibfk_3"
  add_foreign_key "bom_descendant", "bom", column: "descendant_bom_id", name: "bom_descendant_ibfk_4", on_delete: :cascade
  add_foreign_key "bom_descendant", "bom", column: "part_bom_id", name: "bom_descendant_ibfk_3", on_delete: :cascade
  add_foreign_key "car_engine", "car_fuel_type", name: "car_engine_ibfk_1"
  add_foreign_key "car_model", "car_make", name: "car_model_ibfk_1"
  add_foreign_key "car_model_engine_year", "car_engine", name: "car_model_engine_year_ibfk_2"
  add_foreign_key "car_model_engine_year", "car_model", name: "car_model_engine_year_ibfk_1"
  add_foreign_key "car_model_engine_year", "car_year", name: "car_model_engine_year_ibfk_3"
  add_foreign_key "cartridge", "part", name: "cartridge_ibfk_1"
  add_foreign_key "changelog", "user", name: "changelog_ibfk_1"
  add_foreign_key "compressor_wheel", "crit_dim_enum_val", column: "boreless", name: "compressor_wheel_ibfk_6", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compressor_wheel", "crit_dim_enum_val", column: "extendedTips", name: "compressor_wheel_ibfk_4", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compressor_wheel", "crit_dim_enum_val", column: "flatbackSuperback", name: "compressor_wheel_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compressor_wheel", "crit_dim_enum_val", column: "rotation", name: "compressor_wheel_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compressor_wheel", "crit_dim_enum_val", column: "threadCallout", name: "compressor_wheel_ibfk_7", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compressor_wheel", "crit_dim_enum_val", column: "threadHand", name: "compressor_wheel_ibfk_8", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compressor_wheel", "crit_dim_enum_val", column: "threadedBore", name: "compressor_wheel_ibfk_5", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compressor_wheel", "part", name: "compressor_wheel_ibfk_1"
  add_foreign_key "crit_dim", "crit_dim", column: "parent_id", name: "crit_dim_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "crit_dim", "crit_dim_enum", column: "enum_id", name: "crit_dim_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "crit_dim", "part_type", name: "crit_dim_ibfk_1"
  add_foreign_key "gasket", "crit_dim_enum_val", column: "material", name: "gasket_ibfk_5", on_update: :cascade, on_delete: :nullify
  add_foreign_key "gasket", "crit_dim_enum_val", column: "splitSinglePassage", name: "gasket_ibfk_4", on_update: :cascade, on_delete: :nullify
  add_foreign_key "gasket", "crit_dim_enum_val", column: "type", name: "gasket_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "gasket", "gasket_type", name: "gasket_ibfk_2"
  add_foreign_key "gasket", "part", name: "gasket_ibfk_1"
  add_foreign_key "group_role", "groups", name: "group_role_ibfk_1"
  add_foreign_key "group_role", "role", name: "group_role_ibfk_2"
  add_foreign_key "heatshield", "crit_dim_enum_val", column: "matL", name: "heatshield_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "heatshield", "crit_dim_enum_val", column: "rolledLip", name: "heatshield_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "heatshield", "part", name: "heatshield_ibfk_1"
  add_foreign_key "heatshield_shroud", "crit_dim_enum_val", column: "matL", name: "heatshield_shroud_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "heatshield_shroud", "crit_dim_enum_val", column: "rolledLip", name: "heatshield_shroud_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "heatshield_shroud", "part", name: "heatshield_shroud_ibfk_1"
  add_foreign_key "interchange_header", "part", column: "new_part_id", name: "new_part_id"
  add_foreign_key "interchange_item", "interchange_header", name: "interchange_item_ibfk_1"
  add_foreign_key "interchange_item", "part", name: "interchange_item_ibfk_2"
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "boreConfiguration", name: "journal_bearing_ibfk_8", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "endConfiguration", name: "journal_bearing_ibfk_7", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "freePinned", name: "journal_bearing_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "material", name: "journal_bearing_ibfk_6", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "oilFeed", name: "journal_bearing_ibfk_4", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "rotation", name: "journal_bearing_ibfk_5", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "size", name: "journal_bearing_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "crit_dim_enum_val", column: "specialFeaturesOnOff", name: "journal_bearing_ibfk_9", on_update: :cascade, on_delete: :nullify
  add_foreign_key "journal_bearing", "part", name: "journal_bearing_ibfk_1"
  add_foreign_key "kit", "kit_type", name: "kit_ibfk_1"
  add_foreign_key "kit", "part", name: "kit_ibfk_2"
  add_foreign_key "kit_part_common_component", "part", column: "kit_id", name: "kit_part_common_component_ibfk_1"
  add_foreign_key "kit_part_common_component", "part", name: "kit_part_common_component_ibfk_2"
  add_foreign_key "manfr", "manfr", column: "parent_manfr_id", name: "manfr_ibfk_2"
  add_foreign_key "manfr", "manfr_type", name: "manfr_ibfk_1"
  add_foreign_key "mas90sync", "user", name: "usrid_fk"
  add_foreign_key "nozzle_ring", "crit_dim_enum_val", column: "rotation", name: "nozzle_ring_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "nozzle_ring", "part", name: "nozzle_ring_ibfk_1"
  add_foreign_key "part", "manfr", name: "part_ibfk_1"
  add_foreign_key "part", "part_type", name: "part_ibfk_2"
  add_foreign_key "part_turbo", "part", name: "part_turbo_ibfk_1"
  add_foreign_key "part_turbo", "turbo", primary_key: "part_id", name: "part_turbo_ibfk_2"
  add_foreign_key "part_turbo_type", "part", name: "part_turbo_type_ibfk_1"
  add_foreign_key "part_turbo_type", "turbo_type", name: "part_turbo_type_ibfk_2"
  add_foreign_key "part_type", "part_type", column: "parent_part_type_id", name: "part_type_ibfk_1"
  add_foreign_key "piston_ring", "crit_dim_enum_val", column: "material", name: "piston_ring_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "piston_ring", "crit_dim_enum_val", column: "type", name: "piston_ring_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "piston_ring", "part", name: "piston_ring_ibfk_1"
  add_foreign_key "product_image", "part", name: "product_image_ibfk_1"
  add_foreign_key "sales_note", "user", column: "create_uid", name: "fk_sales_note_user_create_uid"
  add_foreign_key "sales_note", "user", column: "write_uid", name: "fk_sales_note_user_write_uid"
  add_foreign_key "sales_note_attachment", "sales_note", name: "sales_note_attachment_sales_note_sales_note_id"
  add_foreign_key "sales_note_attachment", "user", column: "create_uid", name: "sales_note_attachment_user_create_uid"
  add_foreign_key "sales_note_attachment", "user", column: "write_uid", name: "sales_note_attachment_user_write_uid"
  add_foreign_key "sales_note_part", "part", name: "sales_note_part_part_part_id", on_delete: :cascade
  add_foreign_key "sales_note_part", "sales_note", name: "sales_note_part_sales_note_sales_note_id", on_delete: :cascade
  add_foreign_key "sales_note_part", "user", column: "create_uid", name: "sales_note_part_user_create_uid"
  add_foreign_key "sales_note_part", "user", column: "write_uid", name: "sales_note_part_user_write_uid"
  add_foreign_key "standard_bearing_spacer", "bearing_spacer", column: "oversized_part_id", primary_key: "part_id", name: "standard_bearing_spacer_ibfk_2"
  add_foreign_key "standard_bearing_spacer", "bearing_spacer", column: "standard_part_id", primary_key: "part_id", name: "standard_bearing_spacer_ibfk_1"
  add_foreign_key "standard_journal_bearing", "journal_bearing", column: "oversized_part_id", primary_key: "part_id", name: "standard_journal_bearing_ibfk_2"
  add_foreign_key "standard_journal_bearing", "journal_bearing", column: "standard_part_id", primary_key: "part_id", name: "standard_journal_bearing_ibfk_1"
  add_foreign_key "standard_oversize_part", "part", column: "oversize_part_id", name: "standard_oversize_part_oversized_part_id", on_delete: :cascade
  add_foreign_key "standard_oversize_part", "part", column: "standard_part_id", name: "standard_oversize_part_standard_part_id", on_delete: :cascade
  add_foreign_key "turbine_wheel", "crit_dim_enum_val", column: "extendedTips", name: "turbine_wheel_ibfk_7", on_update: :cascade, on_delete: :nullify
  add_foreign_key "turbine_wheel", "crit_dim_enum_val", column: "journalType", name: "turbine_wheel_ibfk_6", on_update: :cascade, on_delete: :nullify
  add_foreign_key "turbine_wheel", "crit_dim_enum_val", column: "rotation", name: "turbine_wheel_ibfk_4", on_update: :cascade, on_delete: :nullify
  add_foreign_key "turbine_wheel", "crit_dim_enum_val", column: "shroudType", name: "turbine_wheel_ibfk_5", on_update: :cascade, on_delete: :nullify
  add_foreign_key "turbine_wheel", "crit_dim_enum_val", column: "thread", name: "turbine_wheel_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "turbine_wheel", "crit_dim_enum_val", column: "threadHand", name: "turbine_wheel_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "turbine_wheel", "part", name: "turbine_wheel_ibfk_1"
  add_foreign_key "turbo", "cool_type", name: "turbo_ibfk_2"
  add_foreign_key "turbo", "part", name: "turbo_ibfk_1"
  add_foreign_key "turbo", "turbo_model", name: "turbo_ibfk_3"
  add_foreign_key "turbo_car_model_engine_year", "car_model_engine_year", name: "turbo_car_model_engine_year_ibfk_1"
  add_foreign_key "turbo_car_model_engine_year", "turbo", column: "part_id", primary_key: "part_id", name: "turbo_car_model_engine_year_ibfk_2"
  add_foreign_key "turbo_model", "turbo_type", name: "turbo_model_ibfk_1"
  add_foreign_key "turbo_type", "manfr", name: "turbo_type_ibfk_1"
  add_foreign_key "user", "auth_provider", name: "fk_authp", on_update: :cascade, on_delete: :nullify
  add_foreign_key "user_group", "groups", name: "user_group_ibfk_2"
  add_foreign_key "user_group", "user", name: "user_group_ibfk_1"
end
