# frozen_string_literal: true

# Typed models for the JmespathFree SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# JmesPath entity data model.
#
# @!attribute [rw] data
#   @return [Object]
#
# @!attribute [rw] query
#   @return [String]
JmesPath = Struct.new(
  :data,
  :query,
  keyword_init: true
)

# Request payload for JmesPath#create.
#
# @!attribute [rw] data
#   @return [Object]
#
# @!attribute [rw] query
#   @return [String]
JmesPathCreateData = Struct.new(
  :data,
  :query,
  keyword_init: true
)

