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

module riverd.soundio.statfun;

import riverd.soundio.types;

extern(C) @nogc nothrow:

/// See also ::soundio_version_major, ::soundio_version_minor, ::soundio_version_patch
const(char)* soundio_version_string();
/// See also ::soundio_version_string, ::soundio_version_minor, ::soundio_version_patch
int soundio_version_major();
/// See also ::soundio_version_major, ::soundio_version_string, ::soundio_version_patch
int soundio_version_minor();
/// See also ::soundio_version_major, ::soundio_version_minor, ::soundio_version_string
int soundio_version_patch();

/// Create a SoundIo context. You may create multiple instances of this to
/// connect to multiple backends. Sets all fields to defaults.
/// Returns `NULL` if and only if memory could not be allocated.
/// See also ::soundio_destroy
SoundIo* soundio_create();
void soundio_destroy(SoundIo* soundio);

/// Tries ::soundio_connect_backend on all available backends in order.
/// Possible errors:
/// * #SoundIoErrorInvalid - already connected
/// * #SoundIoErrorNoMem
/// * #SoundIoErrorSystemResources
/// * #SoundIoErrorNoSuchClient - when JACK returns `JackNoSuchClient`
/// See also ::soundio_disconnect
int soundio_connect(SoundIo* soundio);
/// Instead of calling ::soundio_connect you may call this function to try a
/// specific backend.
/// Possible errors:
/// * #SoundIoErrorInvalid - already connected or invalid backend parameter
/// * #SoundIoErrorNoMem
/// * #SoundIoErrorBackendUnavailable - backend was not compiled in
/// * #SoundIoErrorSystemResources
/// * #SoundIoErrorNoSuchClient - when JACK returns `JackNoSuchClient`
/// * #SoundIoErrorInitAudioBackend - requested `backend` is not active
/// * #SoundIoErrorBackendDisconnected - backend disconnected while connecting
/// See also ::soundio_disconnect
int soundio_connect_backend(SoundIo* soundio, SoundIoBackend backend);
void soundio_disconnect(SoundIo* soundio);

/// Get a string representation of a #SoundIoError
const(char)* soundio_strerror(int error);
/// Get a string representation of a #SoundIoBackend
const(char)* soundio_backend_name(SoundIoBackend backend);

/// Returns the number of available backends.
int soundio_backend_count(SoundIo* soundio);
/// get the available backend at the specified index
/// (0 <= index < ::soundio_backend_count)
SoundIoBackend soundio_get_backend(SoundIo* soundio, int index);

/// Returns whether libsoundio was compiled with backend.
bool soundio_have_backend(SoundIoBackend backend);

/// Atomically update information for all connected devices. Note that calling
/// this function merely flips a pointer; the actual work of collecting device
/// information is done elsewhere. It is performant to call this function many
/// times per second.
///
/// When you call this, the following callbacks might be called:
/// * SoundIo::on_devices_change
/// * SoundIo::on_backend_disconnect
/// This is the only time those callbacks can be called.
///
/// This must be called from the same thread as the thread in which you call
/// these functions:
/// * ::soundio_input_device_count
/// * ::soundio_output_device_count
/// * ::soundio_get_input_device
/// * ::soundio_get_output_device
/// * ::soundio_default_input_device_index
/// * ::soundio_default_output_device_index
///
/// Note that if you do not care about learning about updated devices, you
/// might call this function only once ever and never call
/// ::soundio_wait_events.
void soundio_flush_events(SoundIo* soundio);

/// This function calls ::soundio_flush_events then blocks until another event
/// is ready or you call ::soundio_wakeup. Be ready for spurious wakeups.
void soundio_wait_events(SoundIo* soundio);

/// Makes ::soundio_wait_events stop blocking.
void soundio_wakeup(SoundIo* soundio);

/// If necessary you can manually trigger a device rescan. Normally you will
/// not ever have to call this function, as libsoundio listens to system events
/// for device changes and responds to them by rescanning devices and preparing
/// the new device information for you to be atomically replaced when you call
/// ::soundio_flush_events. However you might run into cases where you want to
/// force trigger a device rescan, for example if an ALSA device has a
/// SoundIoDevice::probe_error.
///
/// After you call this you still have to use ::soundio_flush_events or
/// ::soundio_wait_events and then wait for the
/// SoundIo::on_devices_change callback.
///
/// This can be called from any thread context except for
/// SoundIoOutStream::write_callback and SoundIoInStream::read_callback
void soundio_force_device_scan(SoundIo* soundio);

// Channel Layouts

/// Returns whether the channel count field and each channel id matches in
/// the supplied channel layouts.
bool soundio_channel_layout_equal(const(SoundIoChannelLayout)* a, const(SoundIoChannelLayout)* b);

const(char)* soundio_get_channel_name(SoundIoChannelId id);
/// Given UTF-8 encoded text which is the name of a channel such as
/// "Front Left", "FL", or "front-left", return the corresponding
/// SoundIoChannelId. Returns SoundIoChannelIdInvalid for no match.
SoundIoChannelId soundio_parse_channel_id(const(char)* str, int str_len);

/// Returns the number of builtin channel layouts.
int soundio_channel_layout_builtin_count();
/// Returns a builtin channel layout. 0 <= `index` < ::soundio_channel_layout_builtin_count
///
/// Although `index` is of type `int`, it should be a valid
/// #SoundIoChannelLayoutId enum value.
const(SoundIoChannelLayout)* soundio_channel_layout_get_builtin(int index);

/// Get the default builtin channel layout for the given number of channels.
const(SoundIoChannelLayout)* soundio_channel_layout_get_default(int channel_count);

/// Return the index of `channel` in `layout`, or `-1` if not found.
int soundio_channel_layout_find_channel(const(SoundIoChannelLayout)* layout,
		SoundIoChannelId channel);

/// Populates the name field of layout if it matches a builtin one.
/// returns whether it found a match
bool soundio_channel_layout_detect_builtin(SoundIoChannelLayout* layout);

/// Iterates over preferred_layouts. Returns the first channel layout in
/// preferred_layouts which matches one of the channel layouts in
/// available_layouts. Returns NULL if none matches.
const(SoundIoChannelLayout)* soundio_best_matching_channel_layout(const(SoundIoChannelLayout)* preferred_layouts,
		int preferred_layout_count, const(SoundIoChannelLayout)* available_layouts,
		int available_layout_count);

/// Sorts by channel count, descending.
void soundio_sort_channel_layouts(SoundIoChannelLayout* layouts, int layout_count);

// Sample Formats

/// Returns -1 on invalid format.
int soundio_get_bytes_per_sample(SoundIoFormat format);

/// A frame is one sample per channel.
int soundio_get_bytes_per_frame(SoundIoFormat format, int channel_count);

/// Sample rate is the number of frames per second.
int soundio_get_bytes_per_second(SoundIoFormat format, int channel_count, int sample_rate);

/// Returns string representation of `format`.
const(char)* soundio_format_string(SoundIoFormat format);

// Devices

/// When you call ::soundio_flush_events, a snapshot of all device state is
/// saved and these functions merely access the snapshot data. When you want
/// to check for new devices, call ::soundio_flush_events. Or you can call
/// ::soundio_wait_events to block until devices change. If an error occurs
/// scanning devices in a background thread, SoundIo::on_backend_disconnect is called
/// with the error code.

/// Get the number of input devices.
/// Returns -1 if you never called ::soundio_flush_events.
int soundio_input_device_count(SoundIo* soundio);
/// Get the number of output devices.
/// Returns -1 if you never called ::soundio_flush_events.
int soundio_output_device_count(SoundIo* soundio);

/// Always returns a device. Call ::soundio_device_unref when done.
/// `index` must be 0 <= index < ::soundio_input_device_count
/// Returns NULL if you never called ::soundio_flush_events or if you provide
/// invalid parameter values.
SoundIoDevice* soundio_get_input_device(SoundIo* soundio, int index);
/// Always returns a device. Call ::soundio_device_unref when done.
/// `index` must be 0 <= index < ::soundio_output_device_count
/// Returns NULL if you never called ::soundio_flush_events or if you provide
/// invalid parameter values.
SoundIoDevice* soundio_get_output_device(SoundIo* soundio, int index);

/// returns the index of the default input device
/// returns -1 if there are no devices or if you never called
/// ::soundio_flush_events.
int soundio_default_input_device_index(SoundIo* soundio);

/// returns the index of the default output device
/// returns -1 if there are no devices or if you never called
/// ::soundio_flush_events.
int soundio_default_output_device_index(SoundIo* soundio);

/// Add 1 to the reference count of `device`.
void soundio_device_ref(SoundIoDevice* device);
/// Remove 1 to the reference count of `device`. Clean up if it was the last
/// reference.
void soundio_device_unref(SoundIoDevice* device);

/// Return `true` if and only if the devices have the same SoundIoDevice::id,
/// SoundIoDevice::is_raw, and SoundIoDevice::aim are the same.
bool soundio_device_equal(const(SoundIoDevice)* a, const(SoundIoDevice)* b);

/// Sorts channel layouts by channel count, descending.
void soundio_device_sort_channel_layouts(SoundIoDevice* device);

/// Convenience function. Returns whether `format` is included in the device's
/// supported formats.
bool soundio_device_supports_format(SoundIoDevice* device, SoundIoFormat format);

/// Convenience function. Returns whether `layout` is included in the device's
/// supported channel layouts.
bool soundio_device_supports_layout(SoundIoDevice* device, const(SoundIoChannelLayout)* layout);

/// Convenience function. Returns whether `sample_rate` is included in the
/// device's supported sample rates.
bool soundio_device_supports_sample_rate(SoundIoDevice* device, int sample_rate);

/// Convenience function. Returns the available sample rate nearest to
/// `sample_rate`, rounding up.
int soundio_device_nearest_sample_rate(SoundIoDevice* device, int sample_rate);

// Output Streams
/// Allocates memory and sets defaults. Next you should fill out the struct fields
/// and then call ::soundio_outstream_open. Sets all fields to defaults.
/// Returns `NULL` if and only if memory could not be allocated.
/// See also ::soundio_outstream_destroy
SoundIoOutStream* soundio_outstream_create(SoundIoDevice* device);
/// You may not call this function from the SoundIoOutStream::write_callback thread context.
void soundio_outstream_destroy(SoundIoOutStream* outstream);

/// After you call this function, SoundIoOutStream::software_latency is set to
/// the correct value.
///
/// The next thing to do is call ::soundio_instream_start.
/// If this function returns an error, the outstream is in an invalid state and
/// you must call ::soundio_outstream_destroy on it.
///
/// Possible errors:
/// * #SoundIoErrorInvalid
///   * SoundIoDevice::aim is not #SoundIoDeviceAimOutput
///   * SoundIoOutStream::format is not valid
///   * SoundIoOutStream::channel_count is greater than #SOUNDIO_MAX_CHANNELS
/// * #SoundIoErrorNoMem
/// * #SoundIoErrorOpeningDevice
/// * #SoundIoErrorBackendDisconnected
/// * #SoundIoErrorSystemResources
/// * #SoundIoErrorNoSuchClient - when JACK returns `JackNoSuchClient`
/// * #SoundIoErrorOpeningDevice
/// * #SoundIoErrorIncompatibleBackend - SoundIoOutStream::channel_count is
///   greater than the number of channels the backend can handle.
/// * #SoundIoErrorIncompatibleDevice - stream parameters requested are not
///   compatible with the chosen device.
int soundio_outstream_open(SoundIoOutStream* outstream);

/// After you call this function, SoundIoOutStream::write_callback will be called.
///
/// This function might directly call SoundIoOutStream::write_callback.
///
/// Possible errors:
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorNoMem
/// * #SoundIoErrorSystemResources
/// * #SoundIoErrorBackendDisconnected
int soundio_outstream_start(SoundIoOutStream* outstream);

/// Call this function when you are ready to begin writing to the device buffer.
///  * `outstream` - (in) The output stream you want to write to.
///  * `areas` - (out) The memory addresses you can write data to, one per
///    channel. It is OK to modify the pointers if that helps you iterate.
///  * `frame_count` - (in/out) Provide the number of frames you want to write.
///    Returned will be the number of frames you can actually write, which is
///    also the number of frames that will be written when you call
///    ::soundio_outstream_end_write. The value returned will always be less
///    than or equal to the value provided.
/// It is your responsibility to call this function exactly as many times as
/// necessary to meet the `frame_count_min` and `frame_count_max` criteria from
/// SoundIoOutStream::write_callback.
/// You must call this function only from the SoundIoOutStream::write_callback thread context.
/// After calling this function, write data to `areas` and then call
/// ::soundio_outstream_end_write.
/// If this function returns an error, do not call ::soundio_outstream_end_write.
///
/// Possible errors:
/// * #SoundIoErrorInvalid
///   * `*frame_count` <= 0
///   * `*frame_count` < `frame_count_min` or `*frame_count` > `frame_count_max`
///   * function called too many times without respecting `frame_count_max`
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorUnderflow - an underflow caused this call to fail. You might
///   also get a SoundIoOutStream::underflow_callback, and you might not get
///   this error code when an underflow occurs. Unlike #SoundIoErrorStreaming,
///   the outstream is still in a valid state and streaming can continue.
/// * #SoundIoErrorIncompatibleDevice - in rare cases it might just now
///   be discovered that the device uses non-byte-aligned access, in which
///   case this error code is returned.
int soundio_outstream_begin_write(SoundIoOutStream* outstream,
		SoundIoChannelArea** areas, int* frame_count);

/// Commits the write that you began with ::soundio_outstream_begin_write.
/// You must call this function only from the SoundIoOutStream::write_callback thread context.
///
/// Possible errors:
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorUnderflow - an underflow caused this call to fail. You might
///   also get a SoundIoOutStream::underflow_callback, and you might not get
///   this error code when an underflow occurs. Unlike #SoundIoErrorStreaming,
///   the outstream is still in a valid state and streaming can continue.
int soundio_outstream_end_write(SoundIoOutStream* outstream);

/// Clears the output stream buffer.
/// This function can be called from any thread.
/// This function can be called regardless of whether the outstream is paused
/// or not.
/// Some backends do not support clearing the buffer. On these backends this
/// function will return SoundIoErrorIncompatibleBackend.
/// Some devices do not support clearing the buffer. On these devices this
/// function might return SoundIoErrorIncompatibleDevice.
/// Possible errors:
///
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorIncompatibleBackend
/// * #SoundIoErrorIncompatibleDevice
int soundio_outstream_clear_buffer(SoundIoOutStream* outstream);

/// If the underlying backend and device support pausing, this pauses the
/// stream. SoundIoOutStream::write_callback may be called a few more times if
/// the buffer is not full.
/// Pausing might put the hardware into a low power state which is ideal if your
/// software is silent for some time.
/// This function may be called from any thread context, including
/// SoundIoOutStream::write_callback.
/// Pausing when already paused or unpausing when already unpaused has no
/// effect and returns #SoundIoErrorNone.
///
/// Possible errors:
/// * #SoundIoErrorBackendDisconnected
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorIncompatibleDevice - device does not support
///   pausing/unpausing. This error code might not be returned even if the
///   device does not support pausing/unpausing.
/// * #SoundIoErrorIncompatibleBackend - backend does not support
///   pausing/unpausing.
/// * #SoundIoErrorInvalid - outstream not opened and started
int soundio_outstream_pause(SoundIoOutStream* outstream, bool pause);

/// Obtain the total number of seconds that the next frame written after the
/// last frame written with ::soundio_outstream_end_write will take to become
/// audible. This includes both software and hardware latency. In other words,
/// if you call this function directly after calling ::soundio_outstream_end_write,
/// this gives you the number of seconds that the next frame written will take
/// to become audible.
///
/// This function must be called only from within SoundIoOutStream::write_callback.
///
/// Possible errors:
/// * #SoundIoErrorStreaming
int soundio_outstream_get_latency(SoundIoOutStream* outstream, double* out_latency);

// Input Streams
/// Allocates memory and sets defaults. Next you should fill out the struct fields
/// and then call ::soundio_instream_open. Sets all fields to defaults.
/// Returns `NULL` if and only if memory could not be allocated.
/// See also ::soundio_instream_destroy
SoundIoInStream* soundio_instream_create(SoundIoDevice* device);
/// You may not call this function from SoundIoInStream::read_callback.
void soundio_instream_destroy(SoundIoInStream* instream);

/// After you call this function, SoundIoInStream::software_latency is set to the correct
/// value.
/// The next thing to do is call ::soundio_instream_start.
/// If this function returns an error, the instream is in an invalid state and
/// you must call ::soundio_instream_destroy on it.
///
/// Possible errors:
/// * #SoundIoErrorInvalid
///   * device aim is not #SoundIoDeviceAimInput
///   * format is not valid
///   * requested layout channel count > #SOUNDIO_MAX_CHANNELS
/// * #SoundIoErrorOpeningDevice
/// * #SoundIoErrorNoMem
/// * #SoundIoErrorBackendDisconnected
/// * #SoundIoErrorSystemResources
/// * #SoundIoErrorNoSuchClient
/// * #SoundIoErrorIncompatibleBackend
/// * #SoundIoErrorIncompatibleDevice
int soundio_instream_open(SoundIoInStream* instream);

/// After you call this function, SoundIoInStream::read_callback will be called.
///
/// Possible errors:
/// * #SoundIoErrorBackendDisconnected
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorOpeningDevice
/// * #SoundIoErrorSystemResources
int soundio_instream_start(SoundIoInStream* instream);

/// Call this function when you are ready to begin reading from the device
/// buffer.
/// * `instream` - (in) The input stream you want to read from.
/// * `areas` - (out) The memory addresses you can read data from. It is OK
///   to modify the pointers if that helps you iterate. There might be a "hole"
///   in the buffer. To indicate this, `areas` will be `NULL` and `frame_count`
///   tells how big the hole is in frames.
/// * `frame_count` - (in/out) - Provide the number of frames you want to read;
///   returns the number of frames you can actually read. The returned value
///   will always be less than or equal to the provided value. If the provided
///   value is less than `frame_count_min` from SoundIoInStream::read_callback this function
///   returns with #SoundIoErrorInvalid.
/// It is your responsibility to call this function no more and no fewer than the
/// correct number of times according to the `frame_count_min` and
/// `frame_count_max` criteria from SoundIoInStream::read_callback.
/// You must call this function only from the SoundIoInStream::read_callback thread context.
/// After calling this function, read data from `areas` and then use
/// ::soundio_instream_end_read` to actually remove the data from the buffer
/// and move the read index forward. ::soundio_instream_end_read should not be
/// called if the buffer is empty (`frame_count` == 0), but it should be called
/// if there is a hole.
///
/// Possible errors:
/// * #SoundIoErrorInvalid
///   * `*frame_count` < `frame_count_min` or `*frame_count` > `frame_count_max`
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorIncompatibleDevice - in rare cases it might just now
///   be discovered that the device uses non-byte-aligned access, in which
///   case this error code is returned.
int soundio_instream_begin_read(SoundIoInStream* instream,
		SoundIoChannelArea** areas, int* frame_count);
/// This will drop all of the frames from when you called
/// ::soundio_instream_begin_read.
/// You must call this function only from the SoundIoInStream::read_callback thread context.
/// You must call this function only after a successful call to
/// ::soundio_instream_begin_read.
///
/// Possible errors:
/// * #SoundIoErrorStreaming
int soundio_instream_end_read(SoundIoInStream* instream);

/// If the underyling device supports pausing, this pauses the stream and
/// prevents SoundIoInStream::read_callback from being called. Otherwise this returns
/// #SoundIoErrorIncompatibleDevice.
/// This function may be called from any thread.
/// Pausing when already paused or unpausing when already unpaused has no
/// effect and always returns #SoundIoErrorNone.
///
/// Possible errors:
/// * #SoundIoErrorBackendDisconnected
/// * #SoundIoErrorStreaming
/// * #SoundIoErrorIncompatibleDevice - device does not support pausing/unpausing
int soundio_instream_pause(SoundIoInStream* instream, bool pause);

/// Obtain the number of seconds that the next frame of sound being
/// captured will take to arrive in the buffer, plus the amount of time that is
/// represented in the buffer. This includes both software and hardware latency.
///
/// This function must be called only from within SoundIoInStream::read_callback.
///
/// Possible errors:
/// * #SoundIoErrorStreaming
int soundio_instream_get_latency(SoundIoInStream* instream, double* out_latency);

/// `requested_capacity` in bytes.
/// Returns `NULL` if and only if memory could not be allocated.
/// Use ::soundio_ring_buffer_capacity to get the actual capacity, which might
/// be greater for alignment purposes.
/// See also ::soundio_ring_buffer_destroy
SoundIoRingBuffer* soundio_ring_buffer_create(SoundIo* soundio, int requested_capacity);
void soundio_ring_buffer_destroy(SoundIoRingBuffer* ring_buffer);

/// When you create a ring buffer, capacity might be more than the requested
/// capacity for alignment purposes. This function returns the actual capacity.
int soundio_ring_buffer_capacity(SoundIoRingBuffer* ring_buffer);

/// Do not write more than capacity.
char* soundio_ring_buffer_write_ptr(SoundIoRingBuffer* ring_buffer);
/// `count` in bytes.
void soundio_ring_buffer_advance_write_ptr(SoundIoRingBuffer* ring_buffer, int count);

/// Do not read more than capacity.
char* soundio_ring_buffer_read_ptr(SoundIoRingBuffer* ring_buffer);
/// `count` in bytes.
void soundio_ring_buffer_advance_read_ptr(SoundIoRingBuffer* ring_buffer, int count);

/// Returns how many bytes of the buffer is used, ready for reading.
int soundio_ring_buffer_fill_count(SoundIoRingBuffer* ring_buffer);

/// Returns how many bytes of the buffer is free, ready for writing.
int soundio_ring_buffer_free_count(SoundIoRingBuffer* ring_buffer);

/// Must be called by the writer.
void soundio_ring_buffer_clear(SoundIoRingBuffer* ring_buffer);

