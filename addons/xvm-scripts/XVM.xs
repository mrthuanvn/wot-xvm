/**
 * Set of functions used in XVM for effects and animation
 * case sensitive
 */

/**
 * Predefined dynamic values:
 *   NICK VEHICLE LEVEL RLEVEL TURRET
 *   DMG DMG_RATIO DMG_SRC DMG_DST DMG_KIND HP HP_RATIO HP_MAX
 *   RATING EFF KB BATTLES WINS RATING_T KB_T BATTLES_T WINS_T
 *   C_HP C_HP_RATIO C_VTYPE C_EFF C_RATING C_KB C_RATING_T C_BATTLES_T
 *   A_HP A_HP_RATIO
 */

/**
 *  Legend:
 *   # : operation in progress
 *   + : operation complete and result is visible
 *
 *          0s    0.5s  1s    1.5s  delay Xs
 *  fadeIn  ###++ +++++ +++++ +++++ ~ ~ ~ -----
 *  tint    ##### ##
 *  move up ##### ##### ##### ##### ~ ~ ~ +++++
 *  fadeOut ----- ----- ----- ----- ~ ~ ~ #####
 */
dmg()
{
  set(alpha(1));
  set(shadow({blurX:6, blurY:6, distance:0, strength:2}));
  set(fadeIn(0.3));
  set(tint(0.5, 0xFFFFFF));
  set(move(2, 40, 'up'));
//  append(to(1, {glowFilter:{color:0x00FF00, blurX:10, blurY:10, strength:1, alpha:1}}), 1);
  append(fadeOut(0.5), -0.5);
}
