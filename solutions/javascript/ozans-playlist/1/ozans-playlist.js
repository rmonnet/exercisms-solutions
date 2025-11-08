// @ts-check

/**
 * Removes duplicate tracks from a playlist.
 *
 * @param {string[]} playlist
 * @returns {string[]} new playlist with unique entries
 */
export function removeDuplicates(playlist) {
  let uniqueTracks = new Set(playlist);
  return Array.from(uniqueTracks);
}

/**
 * Checks whether a playlist includes a track.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {boolean} whether the track is in the playlist
 */
export function hasTrack(playlist, track) {
  // note: if the goal of the exercise was not to use Set, we would use Array.includes()
  return new Set(playlist).has(track);
}

/**
 * Adds a track to a playlist.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {string[]} new playlist
 */
export function addTrack(playlist, track) {
  let uniqueTracks = new Set(playlist);
  uniqueTracks.add(track);
  return Array.from(uniqueTracks);
}

/**
 * Deletes a track from a playlist.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {string[]} new playlist
 */
export function deleteTrack(playlist, track) {
  // if this was not an exercise for Set, we would use Array.indexOf() and Array.splice()
  let uniqueTracks = new Set(playlist);
  uniqueTracks.delete(track);
  return Array.from(uniqueTracks);
}

/**
 * Lists the unique artists in a playlist.
 *
 * @param {string[]} playlist
 * @returns {string[]} list of artists
 */
export function listArtists(playlist) {
  let result = new Set();
  playlist.forEach(song => result.add(song.split(' - ')[1]));
  return Array.from(result);
}
