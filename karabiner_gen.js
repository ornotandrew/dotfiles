#!/usr/bin/env node

const capsToEsc = {
  description: 'Remap capslock to escape. Tapping both shifts sends capslock.',
  manipulators: [
    {
      type: 'basic',
      from: { key_code: 'caps_lock', modifiers: { 'optional': [ 'any' ] } },
      to: [ { key_code: 'escape' } ]
    },
    {
      type: 'basic',
      from: { key_code: 'left_shift', modifiers: { mandatory: [ 'right_shift' ], optional: [ 'caps_lock' ] } },
      to: [ { key_code: 'caps_lock' } ]
    },
    {
      type: 'basic',
      from: { key_code: 'right_shift', modifiers: { mandatory: [ 'left_shift' ], optional: [ 'caps_lock' ] } },
      to: [ { key_code: 'caps_lock' } ]
    }
  ]
}


const fnAsCtrlWith = key => ({
  type: 'basic',
  from: { key_code: key, modifiers: { mandatory: ['fn'], optional: ['any'] } },
  to: [ { key_code: key, modifiers: ['left_control'] } ]
})

const letterKeys = 'abcdefghijklmnopqrstuvwxyz'.split('')

const fnToCtrl = {
  description: 'Remap fn to left_control when pressed with keys that do something in combination with left_control',
  manipulators: [
    ...letterKeys,
    'spacebar',
    'return_or_enter',
    'close_bracket',
    'open_bracket'
  ].map(fnAsCtrlWith)
}

const config = {
  'title': 'My custom rules',
  'rules': [
    capsToEsc,
    fnToCtrl
  ]
}

console.log(JSON.stringify(config, null, 2))
