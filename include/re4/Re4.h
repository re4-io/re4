/*
 * Copyright (C) 2019  Vladimir Berlev
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef RE4_RE4_H_
#define RE4_RE4_H_

namespace re4 {

class Re4 {
 public:
  Re4() = default;
  virtual ~Re4() = default;
  int test();
};

}  // namespace re4

#endif  // RE4_RE4_H_