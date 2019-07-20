/*
                                    __
                                   / _|
  __ _ _   _ _ __ ___  _ __ __ _  | |_ ___  ___ ___
 / _` | | | | '__/ _ \| '__/ _` | |  _/ _ \/ __/ __|
| (_| | |_| | | | (_) | | | (_| | | || (_) \__ \__ \
 \__,_|\__,_|_|  \___/|_|  \__,_| |_| \___/|___/___/

Copyright (C) 2018-2019 Luís Ferreira <luis@aurorafoss.org>
Copyright (C) 2018-2019 Aurora Free Open Source Software.

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

module riverd.soundio.types;

import core.stdc.stdarg;

extern(C) @nogc nothrow:

/// See also ::soundio_strerror
enum SoundIoError
{
	SoundIoErrorNone = 0,
	/// Out of memory.
	SoundIoErrorNoMem = 1,
	/// The backend does not appear to be active or running.
	SoundIoErrorInitAudioBackend = 2,
	/// A system resource other than memory was not available.
	SoundIoErrorSystemResources = 3,
	/// Attempted to open a device and failed.
	SoundIoErrorOpeningDevice = 4,
	SoundIoErrorNoSuchDevice = 5,
	/// The programmer did not comply with the API.
	SoundIoErrorInvalid = 6,
	/// libsoundio was compiled without support for that backend.
	SoundIoErrorBackendUnavailable = 7,
	/// An open stream had an error that can only be recovered from by
	/// destroying the stream and creating it again.
	SoundIoErrorStreaming = 8,
	/// Attempted to use a device with parameters it cannot support.
	SoundIoErrorIncompatibleDevice = 9,
	/// When JACK returns `JackNoSuchClient`
	SoundIoErrorNoSuchClient = 10,
	/// Attempted to use parameters that the backend cannot support.
	SoundIoErrorIncompatibleBackend = 11,
	/// Backend server shutdown or became inactive.
	SoundIoErrorBackendDisconnected = 12,
	SoundIoErrorInterrupted = 13,
	/// Buffer underrun occurred.
	SoundIoErrorUnderflow = 14,
	/// Unable to convert to or from UTF-8 to the native string format.
	SoundIoErrorEncodingString = 15
}

/// Specifies where a channel is physically located.
enum SoundIoChannelId
{
	SoundIoChannelIdInvalid = 0,

	SoundIoChannelIdFrontLeft = 1, ///< First of the more commonly supported ids.
	SoundIoChannelIdFrontRight = 2,
	SoundIoChannelIdFrontCenter = 3,
	SoundIoChannelIdLfe = 4,
	SoundIoChannelIdBackLeft = 5,
	SoundIoChannelIdBackRight = 6,
	SoundIoChannelIdFrontLeftCenter = 7,
	SoundIoChannelIdFrontRightCenter = 8,
	SoundIoChannelIdBackCenter = 9,
	SoundIoChannelIdSideLeft = 10,
	SoundIoChannelIdSideRight = 11,
	SoundIoChannelIdTopCenter = 12,
	SoundIoChannelIdTopFrontLeft = 13,
	SoundIoChannelIdTopFrontCenter = 14,
	SoundIoChannelIdTopFrontRight = 15,
	SoundIoChannelIdTopBackLeft = 16,
	SoundIoChannelIdTopBackCenter = 17,
	SoundIoChannelIdTopBackRight = 18, ///< Last of the more commonly supported ids.

	SoundIoChannelIdBackLeftCenter = 19, ///< First of the less commonly supported ids.
	SoundIoChannelIdBackRightCenter = 20,
	SoundIoChannelIdFrontLeftWide = 21,
	SoundIoChannelIdFrontRightWide = 22,
	SoundIoChannelIdFrontLeftHigh = 23,
	SoundIoChannelIdFrontCenterHigh = 24,
	SoundIoChannelIdFrontRightHigh = 25,
	SoundIoChannelIdTopFrontLeftCenter = 26,
	SoundIoChannelIdTopFrontRightCenter = 27,
	SoundIoChannelIdTopSideLeft = 28,
	SoundIoChannelIdTopSideRight = 29,
	SoundIoChannelIdLeftLfe = 30,
	SoundIoChannelIdRightLfe = 31,
	SoundIoChannelIdLfe2 = 32,
	SoundIoChannelIdBottomCenter = 33,
	SoundIoChannelIdBottomLeftCenter = 34,
	SoundIoChannelIdBottomRightCenter = 35,

	/// Mid/side recording
	SoundIoChannelIdMsMid = 36,
	SoundIoChannelIdMsSide = 37,

	/// first order ambisonic channels
	SoundIoChannelIdAmbisonicW = 38,
	SoundIoChannelIdAmbisonicX = 39,
	SoundIoChannelIdAmbisonicY = 40,
	SoundIoChannelIdAmbisonicZ = 41,

	/// X-Y Recording
	SoundIoChannelIdXyX = 42,
	SoundIoChannelIdXyY = 43,

	SoundIoChannelIdHeadphonesLeft = 44, ///< First of the "other" channel ids
	SoundIoChannelIdHeadphonesRight = 45,
	SoundIoChannelIdClickTrack = 46,
	SoundIoChannelIdForeignLanguage = 47,
	SoundIoChannelIdHearingImpaired = 48,
	SoundIoChannelIdNarration = 49,
	SoundIoChannelIdHaptic = 50,
	SoundIoChannelIdDialogCentricMix = 51, ///< Last of the "other" channel ids

	SoundIoChannelIdAux = 52,
	SoundIoChannelIdAux0 = 53,
	SoundIoChannelIdAux1 = 54,
	SoundIoChannelIdAux2 = 55,
	SoundIoChannelIdAux3 = 56,
	SoundIoChannelIdAux4 = 57,
	SoundIoChannelIdAux5 = 58,
	SoundIoChannelIdAux6 = 59,
	SoundIoChannelIdAux7 = 60,
	SoundIoChannelIdAux8 = 61,
	SoundIoChannelIdAux9 = 62,
	SoundIoChannelIdAux10 = 63,
	SoundIoChannelIdAux11 = 64,
	SoundIoChannelIdAux12 = 65,
	SoundIoChannelIdAux13 = 66,
	SoundIoChannelIdAux14 = 67,
	SoundIoChannelIdAux15 = 68
}

/// Built-in channel layouts for convenience.
enum SoundIoChannelLayoutId
{
	SoundIoChannelLayoutIdMono = 0,
	SoundIoChannelLayoutIdStereo = 1,
	SoundIoChannelLayoutId2Point1 = 2,
	SoundIoChannelLayoutId3Point0 = 3,
	SoundIoChannelLayoutId3Point0Back = 4,
	SoundIoChannelLayoutId3Point1 = 5,
	SoundIoChannelLayoutId4Point0 = 6,
	SoundIoChannelLayoutIdQuad = 7,
	SoundIoChannelLayoutIdQuadSide = 8,
	SoundIoChannelLayoutId4Point1 = 9,
	SoundIoChannelLayoutId5Point0Back = 10,
	SoundIoChannelLayoutId5Point0Side = 11,
	SoundIoChannelLayoutId5Point1 = 12,
	SoundIoChannelLayoutId5Point1Back = 13,
	SoundIoChannelLayoutId6Point0Side = 14,
	SoundIoChannelLayoutId6Point0Front = 15,
	SoundIoChannelLayoutIdHexagonal = 16,
	SoundIoChannelLayoutId6Point1 = 17,
	SoundIoChannelLayoutId6Point1Back = 18,
	SoundIoChannelLayoutId6Point1Front = 19,
	SoundIoChannelLayoutId7Point0 = 20,
	SoundIoChannelLayoutId7Point0Front = 21,
	SoundIoChannelLayoutId7Point1 = 22,
	SoundIoChannelLayoutId7Point1Wide = 23,
	SoundIoChannelLayoutId7Point1WideBack = 24,
	SoundIoChannelLayoutIdOctagonal = 25
}

enum SoundIoBackend
{
	SoundIoBackendNone = 0,
	SoundIoBackendJack = 1,
	SoundIoBackendPulseAudio = 2,
	SoundIoBackendAlsa = 3,
	SoundIoBackendCoreAudio = 4,
	SoundIoBackendWasapi = 5,
	SoundIoBackendDummy = 6
}

enum SoundIoDeviceAim
{
	SoundIoDeviceAimInput = 0, ///< capture / recording
	SoundIoDeviceAimOutput = 1 ///< playback
}

/// For your convenience, Native Endian and Foreign Endian constants are defined
/// which point to the respective SoundIoFormat values.
enum SoundIoFormat
{
	SoundIoFormatInvalid = 0,
	SoundIoFormatS8 = 1, ///< Signed 8 bit
	SoundIoFormatU8 = 2, ///< Unsigned 8 bit
	SoundIoFormatS16LE = 3, ///< Signed 16 bit Little Endian
	SoundIoFormatS16BE = 4, ///< Signed 16 bit Big Endian
	SoundIoFormatU16LE = 5, ///< Unsigned 16 bit Little Endian
	SoundIoFormatU16BE = 6, ///< Unsigned 16 bit Little Endian
	SoundIoFormatS24LE = 7, ///< Signed 24 bit Little Endian using low three bytes in 32-bit word
	SoundIoFormatS24BE = 8, ///< Signed 24 bit Big Endian using low three bytes in 32-bit word
	SoundIoFormatU24LE = 9, ///< Unsigned 24 bit Little Endian using low three bytes in 32-bit word
	SoundIoFormatU24BE = 10, ///< Unsigned 24 bit Big Endian using low three bytes in 32-bit word
	SoundIoFormatS32LE = 11, ///< Signed 32 bit Little Endian
	SoundIoFormatS32BE = 12, ///< Signed 32 bit Big Endian
	SoundIoFormatU32LE = 13, ///< Unsigned 32 bit Little Endian
	SoundIoFormatU32BE = 14, ///< Unsigned 32 bit Big Endian
	SoundIoFormatFloat32LE = 15, ///< Float 32 bit Little Endian, Range -1.0 to 1.0
	SoundIoFormatFloat32BE = 16, ///< Float 32 bit Big Endian, Range -1.0 to 1.0
	SoundIoFormatFloat64LE = 17, ///< Float 64 bit Little Endian, Range -1.0 to 1.0
	SoundIoFormatFloat64BE = 18 ///< Float 64 bit Big Endian, Range -1.0 to 1.0
}


enum SOUNDIO_MAX_CHANNELS = 24;
/// The size of this struct is OK to use.
struct SoundIoChannelLayout
{
	const(char)* name;
	int channel_count;
	SoundIoChannelId[SOUNDIO_MAX_CHANNELS] channels;
}

/// The size of this struct is OK to use.
struct SoundIoSampleRateRange
{
	int min;
	int max;
}

/// The size of this struct is OK to use.
struct SoundIoChannelArea
{
	/// Base address of buffer.
	char* ptr;
	/// How many bytes it takes to get from the beginning of one sample to
	/// the beginning of the next sample.
	int step;
}

/// The size of this struct is not part of the API or ABI.
struct SoundIo
{
	/// Optional. Put whatever you want here. Defaults to NULL.
	void* userdata;
	/// Optional callback. Called when the list of devices change. Only called
	/// during a call to ::soundio_flush_events or ::soundio_wait_events.
	void function(SoundIo*) on_devices_change;
	/// Optional callback. Called when the backend disconnects. For example,
	/// when the JACK server shuts down. When this happens, listing devices
	/// and opening streams will always fail with
	/// SoundIoErrorBackendDisconnected. This callback is only called during a
	/// call to ::soundio_flush_events or ::soundio_wait_events.
	/// If you do not supply a callback, the default will crash your program
	/// with an error message. This callback is also called when the thread
	/// that retrieves device information runs into an unrecoverable condition
	/// such as running out of memory.
	///
	/// Possible errors:
	/// * #SoundIoErrorBackendDisconnected
	/// * #SoundIoErrorNoMem
	/// * #SoundIoErrorSystemResources
	/// * #SoundIoErrorOpeningDevice - unexpected problem accessing device
	///   information
	void function(SoundIo*, int err) on_backend_disconnect;
	/// Optional callback. Called from an unknown thread that you should not use
	/// to call any soundio functions. You may use this to signal a condition
	/// variable to wake up. Called when ::soundio_wait_events would be woken up.
	void function(SoundIo*) on_events_signal;

	/// Read-only. After calling ::soundio_connect or ::soundio_connect_backend,
	/// this field tells which backend is currently connected.
	SoundIoBackend current_backend;

	/// Optional: Application name.
	/// PulseAudio uses this for "application name".
	/// JACK uses this for `client_name`.
	/// Must not contain a colon (":").
	const(char)* app_name;

	/// Optional: Real time priority warning.
	/// This callback is fired when making thread real-time priority failed. By
	/// default, it will print to stderr only the first time it is called
	/// a message instructing the user how to configure their system to allow
	/// real-time priority threads. This must be set to a function not NULL.
	/// To silence the warning, assign this to a function that does nothing.
	void function() emit_rtprio_warning;

	/// Optional: JACK info callback.
	/// By default, libsoundio sets this to an empty function in order to
	/// silence stdio messages from JACK. You may override the behavior by
	/// setting this to `NULL` or providing your own function. This is
	/// registered with JACK regardless of whether ::soundio_connect_backend
	/// succeeds.
	void function(const(char)* msg) jack_info_callback;
	/// Optional: JACK error callback.
	/// See SoundIo::jack_info_callback
	void function(const(char)* msg) jack_error_callback;
}

/// The size of this struct is not part of the API or ABI.
struct SoundIoDevice
{
	/// Read-only. Set automatically.
	SoundIo* soundio;

	/// A string of bytes that uniquely identifies this device.
	/// If the same physical device supports both input and output, that makes
	/// one SoundIoDevice for the input and one SoundIoDevice for the output.
	/// In this case, the id of each SoundIoDevice will be the same, and
	/// SoundIoDevice::aim will be different. Additionally, if the device
	/// supports raw mode, there may be up to four devices with the same id:
	/// one for each value of SoundIoDevice::is_raw and one for each value of
	/// SoundIoDevice::aim.
	char* id;
	/// User-friendly UTF-8 encoded text to describe the device.
	char* name;

	/// Tells whether this device is an input device or an output device.
	SoundIoDeviceAim aim;

	/// Channel layouts are handled similarly to SoundIoDevice::formats.
	/// If this information is missing due to a SoundIoDevice::probe_error,
	/// layouts will be NULL. It's OK to modify this data, for example calling
	/// ::soundio_sort_channel_layouts on it.
	/// Devices are guaranteed to have at least 1 channel layout.
	SoundIoChannelLayout* layouts;
	int layout_count;
	/// See SoundIoDevice::current_format
	SoundIoChannelLayout current_layout;

	/// List of formats this device supports. See also
	/// SoundIoDevice::current_format.
	SoundIoFormat* formats;
	/// How many formats are available in SoundIoDevice::formats.
	int format_count;
	/// A device is either a raw device or it is a virtual device that is
	/// provided by a software mixing service such as dmix or PulseAudio (see
	/// SoundIoDevice::is_raw). If it is a raw device,
	/// current_format is meaningless;
	/// the device has no current format until you open it. On the other hand,
	/// if it is a virtual device, current_format describes the
	/// destination sample format that your audio will be converted to. Or,
	/// if you're the lucky first application to open the device, you might
	/// cause the current_format to change to your format.
	/// Generally, you want to ignore current_format and use
	/// whatever format is most convenient
	/// for you which is supported by the device, because when you are the only
	/// application left, the mixer might decide to switch
	/// current_format to yours. You can learn the supported formats via
	/// formats and SoundIoDevice::format_count. If this information is missing
	/// due to a probe error, formats will be `NULL`. If current_format is
	/// unavailable, it will be set to #SoundIoFormatInvalid.
	/// Devices are guaranteed to have at least 1 format available.
	SoundIoFormat current_format;

	/// Sample rate is the number of frames per second.
	/// Sample rate is handled very similar to SoundIoDevice::formats.
	/// If sample rate information is missing due to a probe error, the field
	/// will be set to NULL.
	/// Devices which have SoundIoDevice::probe_error set to #SoundIoErrorNone are
	/// guaranteed to have at least 1 sample rate available.
	SoundIoSampleRateRange* sample_rates;
	/// How many sample rate ranges are available in
	/// SoundIoDevice::sample_rates. 0 if sample rate information is missing
	/// due to a probe error.
	int sample_rate_count;
	/// See SoundIoDevice::current_format
	/// 0 if sample rate information is missing due to a probe error.
	int sample_rate_current;

	/// Software latency minimum in seconds. If this value is unknown or
	/// irrelevant, it is set to 0.0.
	/// For PulseAudio and WASAPI this value is unknown until you open a
	/// stream.
	double software_latency_min;
	/// Software latency maximum in seconds. If this value is unknown or
	/// irrelevant, it is set to 0.0.
	/// For PulseAudio and WASAPI this value is unknown until you open a
	/// stream.
	double software_latency_max;
	/// Software latency in seconds. If this value is unknown or
	/// irrelevant, it is set to 0.0.
	/// For PulseAudio and WASAPI this value is unknown until you open a
	/// stream.
	/// See SoundIoDevice::current_format
	double software_latency_current;

	/// Raw means that you are directly opening the hardware device and not
	/// going through a proxy such as dmix, PulseAudio, or JACK. When you open a
	/// raw device, other applications on the computer are not able to
	/// simultaneously access the device. Raw devices do not perform automatic
	/// resampling and thus tend to have fewer formats available.
	bool is_raw;

	/// Devices are reference counted. See ::soundio_device_ref and
	/// ::soundio_device_unref.
	int ref_count;

	/// This is set to a SoundIoError representing the result of the device
	/// probe. Ideally this will be SoundIoErrorNone in which case all the
	/// fields of the device will be populated. If there is an error code here
	/// then information about formats, sample rates, and channel layouts might
	/// be missing.
	///
	/// Possible errors:
	/// * #SoundIoErrorOpeningDevice
	/// * #SoundIoErrorNoMem
	int probe_error;
}

/// The size of this struct is not part of the API or ABI.
struct SoundIoOutStream
{
	/// Populated automatically when you call ::soundio_outstream_create.
	SoundIoDevice* device;

	/// Defaults to #SoundIoFormatFloat32NE, followed by the first one
	/// supported.
	SoundIoFormat format;

	/// Sample rate is the number of frames per second.
	/// Defaults to 48000 (and then clamped into range).
	int sample_rate;

	/// Defaults to Stereo, if available, followed by the first layout
	/// supported.
	SoundIoChannelLayout layout;

	/// Ignoring hardware latency, this is the number of seconds it takes for
	/// the last sample in a full buffer to be played.
	/// After you call ::soundio_outstream_open, this value is replaced with the
	/// actual software latency, as near to this value as possible.
	/// On systems that support clearing the buffer, this defaults to a large
	/// latency, potentially upwards of 2 seconds, with the understanding that
	/// you will call ::soundio_outstream_clear_buffer when you want to reduce
	/// the latency to 0. On systems that do not support clearing the buffer,
	/// this defaults to a reasonable lower latency value.
	///
	/// On backends with high latencies (such as 2 seconds), `frame_count_min`
	/// will be 0, meaning you don't have to fill the entire buffer. In this
	/// case, the large buffer is there if you want it; you only have to fill
	/// as much as you want. On backends like JACK, `frame_count_min` will be
	/// equal to `frame_count_max` and if you don't fill that many frames, you
	/// will get glitches.
	///
	/// If the device has unknown software latency min and max values, you may
	/// still set this, but you might not get the value you requested.
	/// For PulseAudio, if you set this value to non-default, it sets
	/// `PA_STREAM_ADJUST_LATENCY` and is the value used for `maxlength` and
	/// `tlength`.
	///
	/// For JACK, this value is always equal to
	/// SoundIoDevice::software_latency_current of the device.
	double software_latency;

	/// Defaults to NULL. Put whatever you want here.
	void* userdata;
	/// In this callback, you call ::soundio_outstream_begin_write and
	/// ::soundio_outstream_end_write as many times as necessary to write
	/// at minimum `frame_count_min` frames and at maximum `frame_count_max`
	/// frames. `frame_count_max` will always be greater than 0. Note that you
	/// should write as many frames as you can; `frame_count_min` might be 0 and
	/// you can still get a buffer underflow if you always write
	/// `frame_count_min` frames.
	///
	/// For Dummy, ALSA, and PulseAudio, `frame_count_min` will be 0. For JACK
	/// and CoreAudio `frame_count_min` will be equal to `frame_count_max`.
	///
	/// The code in the supplied function must be suitable for real-time
	/// execution. That means that it cannot call functions that might block
	/// for a long time. This includes all I/O functions (disk, TTY, network),
	/// malloc, free, printf, pthread_mutex_lock, sleep, wait, poll, select,
	/// pthread_join, pthread_cond_wait, etc.
	void function(SoundIoOutStream*, int frame_count_min, int frame_count_max) write_callback;
	/// This optional callback happens when the sound device runs out of
	/// buffered audio data to play. After this occurs, the outstream waits
	/// until the buffer is full to resume playback.
	/// This is called from the SoundIoOutStream::write_callback thread context.
	void function(SoundIoOutStream*) underflow_callback;
	/// Optional callback. `err` is always SoundIoErrorStreaming.
	/// SoundIoErrorStreaming is an unrecoverable error. The stream is in an
	/// invalid state and must be destroyed.
	/// If you do not supply error_callback, the default callback will print
	/// a message to stderr and then call `abort`.
	/// This is called from the SoundIoOutStream::write_callback thread context.
	void function(SoundIoOutStream*, int err) error_callback;

	/// Optional: Name of the stream. Defaults to "SoundIoOutStream"
	/// PulseAudio uses this for the stream name.
	/// JACK uses this for the client name of the client that connects when you
	/// open the stream.
	/// WASAPI uses this for the session display name.
	/// Must not contain a colon (":").
	const(char)* name;

	/// Optional: Hint that this output stream is nonterminal. This is used by
	/// JACK and it means that the output stream data originates from an input
	/// stream. Defaults to `false`.
	bool non_terminal_hint;

	/// computed automatically when you call ::soundio_outstream_open
	int bytes_per_frame;
	/// computed automatically when you call ::soundio_outstream_open
	int bytes_per_sample;

	/// If setting the channel layout fails for some reason, this field is set
	/// to an error code. Possible error codes are:
	/// * #SoundIoErrorIncompatibleDevice
	int layout_error;
}

/// The size of this struct is not part of the API or ABI.
struct SoundIoInStream
{
	/// Populated automatically when you call ::soundio_outstream_create.
	SoundIoDevice* device;

	/// Defaults to #SoundIoFormatFloat32NE, followed by the first one
	/// supported.
	SoundIoFormat format;

	/// Sample rate is the number of frames per second.
	/// Defaults to max(sample_rate_min, min(sample_rate_max, 48000))
	int sample_rate;

	/// Defaults to Stereo, if available, followed by the first layout
	/// supported.
	SoundIoChannelLayout layout;

	/// Ignoring hardware latency, this is the number of seconds it takes for a
	/// captured sample to become available for reading.
	/// After you call ::soundio_instream_open, this value is replaced with the
	/// actual software latency, as near to this value as possible.
	/// A higher value means less CPU usage. Defaults to a large value,
	/// potentially upwards of 2 seconds.
	/// If the device has unknown software latency min and max values, you may
	/// still set this, but you might not get the value you requested.
	/// For PulseAudio, if you set this value to non-default, it sets
	/// `PA_STREAM_ADJUST_LATENCY` and is the value used for `fragsize`.
	/// For JACK, this value is always equal to
	/// SoundIoDevice::software_latency_current
	double software_latency;

	/// Defaults to NULL. Put whatever you want here.
	void* userdata;
	/// In this function call ::soundio_instream_begin_read and
	/// ::soundio_instream_end_read as many times as necessary to read at
	/// minimum `frame_count_min` frames and at maximum `frame_count_max`
	/// frames. If you return from read_callback without having read
	/// `frame_count_min`, the frames will be dropped. `frame_count_max` is how
	/// many frames are available to read.
	///
	/// The code in the supplied function must be suitable for real-time
	/// execution. That means that it cannot call functions that might block
	/// for a long time. This includes all I/O functions (disk, TTY, network),
	/// malloc, free, printf, pthread_mutex_lock, sleep, wait, poll, select,
	/// pthread_join, pthread_cond_wait, etc.
	void function(SoundIoInStream*, int frame_count_min, int frame_count_max) read_callback;
	/// This optional callback happens when the sound device buffer is full,
	/// yet there is more captured audio to put in it.
	/// This is never fired for PulseAudio.
	/// This is called from the SoundIoInStream::read_callback thread context.
	void function(SoundIoInStream*) overflow_callback;
	/// Optional callback. `err` is always SoundIoErrorStreaming.
	/// SoundIoErrorStreaming is an unrecoverable error. The stream is in an
	/// invalid state and must be destroyed.
	/// If you do not supply `error_callback`, the default callback will print
	/// a message to stderr and then abort().
	/// This is called from the SoundIoInStream::read_callback thread context.
	void function(SoundIoInStream*, int err) error_callback;

	/// Optional: Name of the stream. Defaults to "SoundIoInStream";
	/// PulseAudio uses this for the stream name.
	/// JACK uses this for the client name of the client that connects when you
	/// open the stream.
	/// WASAPI uses this for the session display name.
	/// Must not contain a colon (":").
	const(char)* name;

	/// Optional: Hint that this input stream is nonterminal. This is used by
	/// JACK and it means that the data received by the stream will be
	/// passed on or made available to another stream. Defaults to `false`.
	bool non_terminal_hint;

	/// computed automatically when you call ::soundio_instream_open
	int bytes_per_frame;
	/// computed automatically when you call ::soundio_instream_open
	int bytes_per_sample;

	/// If setting the channel layout fails for some reason, this field is set
	/// to an error code. Possible error codes are: #SoundIoErrorIncompatibleDevice
	int layout_error;
}

version (BigEndian)
{
	enum SoundIoFormatS16NE = SoundIoFormat.SoundIoFormatS16BE;
	enum SoundIoFormatU16NE = SoundIoFormat.SoundIoFormatU16BE;
	enum SoundIoFormatS24NE = SoundIoFormat.SoundIoFormatS24BE;
	enum SoundIoFormatU24NE = SoundIoFormat.SoundIoFormatU24BE;
	enum SoundIoFormatS32NE = SoundIoFormat.SoundIoFormatS32BE;
	enum SoundIoFormatU32NE = SoundIoFormat.SoundIoFormatU32BE;
	enum SoundIoFormatFloat32NE = SoundIoFormat.SoundIoFormatFloat32BE;
	enum SoundIoFormatFloat64NE = SoundIoFormat.SoundIoFormatFloat64BE;

	enum SoundIoFormatS16FE = SoundIoFormat.SoundIoFormatS16LE;
	enum SoundIoFormatU16FE = SoundIoFormat.SoundIoFormatU16LE;
	enum SoundIoFormatS24FE = SoundIoFormat.SoundIoFormatS24LE;
	enum SoundIoFormatU24FE = SoundIoFormat.SoundIoFormatU24LE;
	enum SoundIoFormatS32FE = SoundIoFormat.SoundIoFormatS32LE;
	enum SoundIoFormatU32FE = SoundIoFormat.SoundIoFormatU32LE;
	enum SoundIoFormatFloat32FE = SoundIoFormat.SoundIoFormatFloat32LE;
	enum SoundIoFormatFloat64FE = SoundIoFormat.SoundIoFormatFloat64LE;
}
else version (LittleEndian)
{
	enum SoundIoFormatS16NE = SoundIoFormat.SoundIoFormatS16LE;
	enum SoundIoFormatU16NE = SoundIoFormat.SoundIoFormatU16LE;
	enum SoundIoFormatS24NE = SoundIoFormat.SoundIoFormatS24LE;
	enum SoundIoFormatU24NE = SoundIoFormat.SoundIoFormatU24LE;
	enum SoundIoFormatS32NE = SoundIoFormat.SoundIoFormatS32LE;
	enum SoundIoFormatU32NE = SoundIoFormat.SoundIoFormatU32LE;
	enum SoundIoFormatFloat32NE = SoundIoFormat.SoundIoFormatFloat32LE;
	enum SoundIoFormatFloat64NE = SoundIoFormat.SoundIoFormatFloat64LE;

	enum SoundIoFormatS16FE = SoundIoFormat.SoundIoFormatS16BE;
	enum SoundIoFormatU16FE = SoundIoFormat.SoundIoFormatU16BE;
	enum SoundIoFormatS24FE = SoundIoFormat.SoundIoFormatS24BE;
	enum SoundIoFormatU24FE = SoundIoFormat.SoundIoFormatU24BE;
	enum SoundIoFormatS32FE = SoundIoFormat.SoundIoFormatS32BE;
	enum SoundIoFormatU32FE = SoundIoFormat.SoundIoFormatU32BE;
	enum SoundIoFormatFloat32FE = SoundIoFormat.SoundIoFormatFloat32BE;
	enum SoundIoFormatFloat64FE = SoundIoFormat.SoundIoFormatFloat64BE;
}
else
{
	static assert(false, "unknown byte order");
}

/// A ring buffer is a single-reader single-writer lock-free fixed-size queue.
/// libsoundio ring buffers use memory mapping techniques to enable a
/// contiguous buffer when reading or writing across the boundary of the ring
/// buffer's capacity.
struct SoundIoRingBuffer;

extern(C) @nogc nothrow {
	alias da_soundio_version_major = int function(); ///
	alias da_soundio_version_minor = int function(); ///
	alias da_soundio_version_patch = int function(); ///
	alias da_soundio_create = SoundIo* function(); ///
	alias da_soundio_instream_create = SoundIoInStream* function(SoundIoDevice* device); ///
	alias da_soundio_ring_buffer_create = SoundIoRingBuffer* function(SoundIo* soundio, int requested_capacity); ///
	alias da_soundio_ring_buffer_write_ptr = char* function(SoundIoRingBuffer* ring_buffer); ///
	alias da_soundio_ring_buffer_read_ptr = char* function(SoundIoRingBuffer* ring_buffer); ///
	alias da_soundio_get_input_device = SoundIoDevice* function(SoundIo* soundio, int index); ///
	alias da_soundio_get_output_device = SoundIoDevice* function(SoundIo* soundio, int index); ///
	alias da_soundio_outstream_create = SoundIoOutStream* function(SoundIoDevice* device); ///
	alias da_soundio_best_matching_channel_layout = const(SoundIoChannelLayout)* function(const(SoundIoChannelLayout)* preferred_layouts, int preferred_layout_count, const(SoundIoChannelLayout)* available_layouts, int available_layout_count); ///
	alias da_soundio_channel_layout_get_builtin = const(SoundIoChannelLayout)* function(int index); ///
	alias da_soundio_channel_layout_get_default = const(SoundIoChannelLayout)* function(int channel_count); ///
	alias da_soundio_format_string = const(char)* function(SoundIoFormat format); ///
	alias da_soundio_strerror = const(char)* function(int error); ///
	alias da_soundio_backend_name = const(char)* function(SoundIoBackend backend); ///
	alias da_soundio_get_channel_name = const(char)* function(SoundIoChannelId id); ///
	alias da_soundio_version_string = const(char)* function(); ///
	alias da_soundio_destroy = void function(SoundIo* soundio); ///
	alias da_soundio_connect = int function(SoundIo* soundio); ///
	alias da_soundio_connect_backend = int function(SoundIo* soundio, SoundIoBackend backend); ///
	alias da_soundio_disconnect = void function(SoundIo* soundio); ///
	alias da_soundio_backend_count = int function(SoundIo* soundio); ///
	alias da_soundio_get_backend = SoundIoBackend function(SoundIo* soundio, int index); ///
	alias da_soundio_have_backend = bool function(SoundIoBackend backend); ///
	alias da_soundio_flush_events = void function(SoundIo* soundio); ///
	alias da_soundio_wait_events = void function(SoundIo* soundio); ///
	alias da_soundio_wakeup = void function(SoundIo* soundio); ///
	alias da_soundio_force_device_scan = void function(SoundIo* soundio); ///
	alias da_soundio_channel_layout_equal = bool function(const(SoundIoChannelLayout)* a, const(SoundIoChannelLayout)* b); ///
	alias da_soundio_parse_channel_id = SoundIoChannelId function(const(char)* str, int str_len); ///
	alias da_soundio_channel_layout_builtin_count = int function(); ///
	alias da_soundio_channel_layout_find_channel = int function(const(SoundIoChannelLayout)* layout, SoundIoChannelId channel); ///
	alias da_soundio_channel_layout_detect_builtin = bool function(SoundIoChannelLayout* layout); ///
	alias da_soundio_sort_channel_layouts = void function(SoundIoChannelLayout* layouts, int layout_count); ///
	alias da_soundio_get_bytes_per_sample = int function(SoundIoFormat format); ///
	alias da_soundio_get_bytes_per_frame = int function(SoundIoFormat format, int channel_count); ///
	alias da_soundio_get_bytes_per_second = int function(SoundIoFormat format, int channel_count, int sample_rate); ///
	alias da_soundio_input_device_count = int function(SoundIo* soundio); ///
	alias da_soundio_output_device_count = int function(SoundIo* soundio); ///
	alias da_soundio_default_input_device_index = int function(SoundIo* soundio); ///
	alias da_soundio_default_output_device_index = int function(SoundIo* soundio); ///
	alias da_soundio_device_ref = void function(SoundIoDevice* device); ///
	alias da_soundio_device_unref = void function(SoundIoDevice* device); ///
	alias da_soundio_device_equal = bool function(const(SoundIoDevice)* a, const(SoundIoDevice)* b); ///
	alias da_soundio_device_sort_channel_layouts = void function(SoundIoDevice* device); ///
	alias da_soundio_device_supports_format = bool function(SoundIoDevice* device, SoundIoFormat format); ///
	alias da_soundio_device_supports_layout = bool function(SoundIoDevice* device, const(SoundIoChannelLayout)* layout); ///
	alias da_soundio_device_supports_sample_rate = bool function(SoundIoDevice* device, int sample_rate); ///
	alias da_soundio_device_nearest_sample_rate = int function(SoundIoDevice* device, int sample_rate); ///
	alias da_soundio_outstream_destroy = void function(SoundIoOutStream* outstream); ///
	alias da_soundio_outstream_open = int function(SoundIoOutStream* outstream); ///
	alias da_soundio_outstream_start = int function(SoundIoOutStream* outstream); ///
	alias da_soundio_outstream_begin_write = int function(SoundIoOutStream* outstream, SoundIoChannelArea** areas, int* frame_count); ///
	alias da_soundio_outstream_end_write = int function(SoundIoOutStream* outstream); ///
	alias da_soundio_outstream_clear_buffer = int function(SoundIoOutStream* outstream); ///
	alias da_soundio_outstream_pause = int function(SoundIoOutStream* outstream, bool pause); ///
	alias da_soundio_outstream_get_latency = int function(SoundIoOutStream* outstream, double* out_latency); ///
	alias da_soundio_instream_destroy = void function(SoundIoInStream* instream); ///
	alias da_soundio_instream_open = int function(SoundIoInStream* instream); ///
	alias da_soundio_instream_start = int function(SoundIoInStream* instream); ///
	alias da_soundio_instream_begin_read = int function(SoundIoInStream* instream, SoundIoChannelArea** areas, int* frame_count); ///
	alias da_soundio_instream_end_read = int function(SoundIoInStream* instream); ///
	alias da_soundio_instream_pause = int function(SoundIoInStream* instream, bool pause); ///
	alias da_soundio_instream_get_latency = int function(SoundIoInStream* instream, double* out_latency); ///
	alias da_soundio_ring_buffer_destroy = void function(SoundIoRingBuffer* ring_buffer); ///
	alias da_soundio_ring_buffer_capacity = int function(SoundIoRingBuffer* ring_buffer); ///
	alias da_soundio_ring_buffer_advance_write_ptr = void function(SoundIoRingBuffer* ring_buffer, int count); ///
	alias da_soundio_ring_buffer_advance_read_ptr = void function(SoundIoRingBuffer* ring_buffer, int count); ///
	alias da_soundio_ring_buffer_fill_count = int function(SoundIoRingBuffer* ring_buffer); ///
	alias da_soundio_ring_buffer_free_count = int function(SoundIoRingBuffer* ring_buffer); ///
	alias da_soundio_ring_buffer_clear = void function(SoundIoRingBuffer* ring_buffer); ///
}
