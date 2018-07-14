//-----------------------------------------------------------------------------
// Phina.Util.Grid

/* global phina */

exports._setGrid = function(axis, columns, isLoop, offset, target) {
  var grid = target[axis];

  grid.columns = columns;
  grid.loop = isLoop;
  grid.offset = offset;

  return target;
};

exports._getSpan = function(axis, sp, target) {
  return target[axis].span(sp);
};

exports._getUnit = function(axis, target) {
  return target[axis].unit();
};

exports._getCenter = function(axis, target) {
  return target[axis].center();
};

exports._getGrid = function(axis, target) {
  var grid = target[axis].grid;

  return phina.util.Grid(grid.width, grid.columns, grid.loop, grid.offset);
};

exports._newGrid = function(width, columns, isLoop, offset) {
  return phina.util.Grid(width, columns, isLoop, offset);
};

exports._span = function(index, grid) {
  return grid.span(index);
};

exports._unit = function(grid) {
  return grid.unit();
};

exports._center = function(grid) {
  return grid.center();
};
