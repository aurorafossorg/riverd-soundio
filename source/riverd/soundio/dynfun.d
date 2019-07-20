/*
                                    __
                                   / _|
  __ _ _   _ _ __ ___  _ __ __ _  | |_ ___  ___ ___
 / _` | | | | '__/ _ \| '__/ _` | |  _/ _ \/ __/ __|
| (_| | |_| | | | (_) | | | (_| | | || (_) \__ \__ \
 \__,_|\__,_|_|  \___/|_|  \__,_| |_| \___/|___/___/

Copyright (C) 2018-2019 Aurora Free Open Source Software.
Copyright (C) 2018-2019 Luís Ferreira <luis@aurorafoss.org>

This file is part of the Aurora Free Open Source Software. This
organization promote free and open source software that you can
redistribute and/or modify under the terms of the GNU Lesser General
Public License Version 3 as published by the Free Software Foundation or
(at your option) any later version approved by the Aurora Free Open Source
Software Organization. The license is available in the package root path
as 'LICENSE' file. Please review the following information to ensure the
GNU Lesser General Public License version 3 requirements will be met:
https://www.gnu.org/licenses/lgpl.html .

Alternatively, this file may be used under the terms of the GNU General
Public License version 3 or later as published by the Free Software
Foundation. Please review the following information to ensure the GNU
General Public License requirements will be met:
http://www.gnu.org/licenses/gpl-3.0.html.

NOTE: All products, services or anything associated to trademarks and
service marks used or referenced on this file are the property of their
respective companies/owners or its subsidiaries. Other names and brands
may be claimed as the property of others.

For more info about intellectual property visit: aurorafoss.org or
directly send an email to: contact (at) aurorafoss.org .
*/

module riverd.soundio.dynfun;

import riverd.soundio.types;

__gshared {
	// stfu
	da_soundio_version_major soundio_version_major; ///
	da_soundio_version_minor soundio_version_minor; ///
	da_soundio_version_patch soundio_version_patch; ///
	da_soundio_create soundio_create; ///
	da_soundio_instream_create soundio_instream_create; ///
	da_soundio_ring_buffer_create soundio_ring_buffer_create; ///
	da_soundio_ring_buffer_write_ptr soundio_ring_buffer_write_ptr; ///
	da_soundio_ring_buffer_read_ptr soundio_ring_buffer_read_ptr; ///
	da_soundio_get_input_device soundio_get_input_device; ///
	da_soundio_get_output_device soundio_get_output_device; ///
	da_soundio_outstream_create soundio_outstream_create; ///
	da_soundio_best_matching_channel_layout soundio_best_matching_channel_layout; ///
	da_soundio_channel_layout_get_builtin soundio_channel_layout_get_builtin; ///
	da_soundio_channel_layout_get_default soundio_channel_layout_get_default; ///
	da_soundio_format_string soundio_format_string; ///
	da_soundio_strerror soundio_strerror; ///
	da_soundio_backend_name soundio_backend_name; ///
	da_soundio_get_channel_name soundio_get_channel_name; ///
	da_soundio_version_string soundio_version_string; ///
	da_soundio_destroy soundio_destroy; ///
	da_soundio_connect soundio_connect; ///
	da_soundio_connect_backend soundio_connect_backend; ///
	da_soundio_disconnect soundio_disconnect; ///
	da_soundio_backend_count soundio_backend_count; ///
	da_soundio_get_backend soundio_get_backend; ///
	da_soundio_have_backend soundio_have_backend; ///
	da_soundio_flush_events soundio_flush_events; ///
	da_soundio_wait_events soundio_wait_events; ///
	da_soundio_wakeup soundio_wakeup; ///
	da_soundio_force_device_scan soundio_force_device_scan; ///
	da_soundio_channel_layout_equal soundio_channel_layout_equal; ///
	da_soundio_parse_channel_id soundio_parse_channel_id; ///
	da_soundio_channel_layout_builtin_count soundio_channel_layout_builtin_count; ///
	da_soundio_channel_layout_find_channel soundio_channel_layout_find_channel; ///
	da_soundio_channel_layout_detect_builtin soundio_channel_layout_detect_builtin; ///
	da_soundio_sort_channel_layouts soundio_sort_channel_layouts; ///
	da_soundio_get_bytes_per_sample soundio_get_bytes_per_sample; ///
	da_soundio_get_bytes_per_frame soundio_get_bytes_per_frame; ///
	da_soundio_get_bytes_per_second soundio_get_bytes_per_second; ///
	da_soundio_input_device_count soundio_input_device_count; ///
	da_soundio_output_device_count soundio_output_device_count; ///
	da_soundio_default_input_device_index soundio_default_input_device_index; ///
	da_soundio_default_output_device_index soundio_default_output_device_index; ///
	da_soundio_device_ref soundio_device_ref; ///
	da_soundio_device_unref soundio_device_unref; ///
	da_soundio_device_equal soundio_device_equal; ///
	da_soundio_device_sort_channel_layouts soundio_device_sort_channel_layouts; ///
	da_soundio_device_supports_format soundio_device_supports_format; ///
	da_soundio_device_supports_layout soundio_device_supports_layout; ///
	da_soundio_device_supports_sample_rate soundio_device_supports_sample_rate; ///
	da_soundio_device_nearest_sample_rate soundio_device_nearest_sample_rate; ///
	da_soundio_outstream_destroy soundio_outstream_destroy; ///
	da_soundio_outstream_open soundio_outstream_open; ///
	da_soundio_outstream_start soundio_outstream_start; ///
	da_soundio_outstream_begin_write soundio_outstream_begin_write; ///
	da_soundio_outstream_end_write soundio_outstream_end_write; ///
	da_soundio_outstream_clear_buffer soundio_outstream_clear_buffer; ///
	da_soundio_outstream_pause soundio_outstream_pause; ///
	da_soundio_outstream_get_latency soundio_outstream_get_latency; ///
	da_soundio_instream_destroy soundio_instream_destroy; ///
	da_soundio_instream_open soundio_instream_open; ///
	da_soundio_instream_start soundio_instream_start; ///
	da_soundio_instream_begin_read soundio_instream_begin_read; ///
	da_soundio_instream_end_read soundio_instream_end_read; ///
	da_soundio_instream_pause soundio_instream_pause; ///
	da_soundio_instream_get_latency soundio_instream_get_latency; ///
	da_soundio_ring_buffer_destroy soundio_ring_buffer_destroy; ///
	da_soundio_ring_buffer_capacity soundio_ring_buffer_capacity; ///
	da_soundio_ring_buffer_advance_write_ptr soundio_ring_buffer_advance_write_ptr; ///
	da_soundio_ring_buffer_advance_read_ptr soundio_ring_buffer_advance_read_ptr; ///
	da_soundio_ring_buffer_fill_count soundio_ring_buffer_fill_count; ///
	da_soundio_ring_buffer_free_count soundio_ring_buffer_free_count; ///
	da_soundio_ring_buffer_clear soundio_ring_buffer_clear; ///
}
