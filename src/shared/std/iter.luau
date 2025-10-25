--- Perform a map operation on a table of values, returns a fresh clone of the table with the modified values
local function map<T>(tbl: {T}, fn: (T) -> T): {T}
   local result = table.create(#tbl)
   for i, value in tbl do
      result[i] = fn(value)
   end
   return result
end

--- Pretty much just an inline for loop
local function for_each<T>(tbl: {T}, fn: (number, T) -> ())
   for i, value in tbl do
      fn(i, value)
   end
end

--- The immutable filter you should use like 98% of the time, use this instead of `table.remove` in series
local function filter<T>(tbl: {T}, fn: (T) -> boolean?): {T}
   local result = {}
   for _, value in tbl do
      if fn(value) then
         table.insert(result, value)
      end
   end
   return result
end

--- Mutable filter, should only be used on large tables or when memory constraints are tight
local function filter_inplace<T>(tbl: {T}, fn: (T) -> boolean?): {T}
   local write = 1
   local len = #tbl
   for read = 1, len do
      if fn(tbl[read]) then
         tbl[write] = tbl[write]
         write += 1
      end
   end
   for i = len, write, -1 do
      tbl[i] = nil
   end
   return tbl
end

return {
   map = map,
   for_each = for_each,
   filter = filter,
   filter_inplace = filter_inplace
}