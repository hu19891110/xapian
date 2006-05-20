<?php
/* PHP4 specific tests.
 *
 * Copyright (C) 2006 Olly Betts
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
 * USA
 */

# Check PHP4 handling of Xapian::DocNotFoundError
$old_error_reporting = error_reporting();
if ($old_error_reporting & E_WARNING)
    error_reporting($old_error_reporting ^ E_WARNING);
$doc2 = Database_get_document($db, 2);
if ($doc2 != null) {
    print "Retrieved non-existent document\n";
    exit(1);
}
if ($old_error_reporting & E_WARNING)
    error_reporting($old_error_reporting);
?>
