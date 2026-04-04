//
//  JavaScriptBridge.js
//  javascript-bridge-framework
//
//  Created by Fang Ling on 2026/4/4.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

let _instance
let _memory
let elements
// let eventListeners

function readString(string, count) {
  const characters = new Uint32Array(
    _memory.buffer,
    string,
    Number(count)
  )
  return String.fromCodePoint(...characters)
}

function getElement(elementID) {
  if (elementID === "") {
    return document.body
  }

  return elements.get(elementID)
}

export function JavaScriptBridge_Initialize(instance, memory) {
  _instance = instance
  _memory = memory
  elements = new Map()
//    this.eventListeners = new Map()
}

export function JavaScriptBridge_InitializeElement(
  elementIDString,
  elementIDStringCount,
  elementType
) {
  const elementTypeString = (() => {
    switch (elementType) {
      case 1: return "div"
      case 2: return "span"
      case 3: return "button"
    }
  })()

  const elementID = readString(elementIDString, elementIDStringCount)
  const element = document.createElement(elementTypeString)
  element.className = "view"
  elements.set(elementID, element)
}

export function JavaScriptBridge_GetWindowWidth() {
  return window.innerWidth
}

export function JavaScriptBridge_GetWindowHeight() {
  return window.innerHeight
}

export function JavaScriptBridge_SetElementStyleProperty(
  elementIDString,
  elementIDStringCount,
  propertyString,
  propertyStringCount,
  valueString,
  valueStringCount
) {
  const elementID = readString(elementIDString, elementIDStringCount)

  getElement(elementID)?.style.setProperty(
    readString(propertyString, propertyStringCount),
    readString(valueString, valueStringCount)
  )
}

export function JavaScriptBridge_RemoveElementStyleProperty(
  elementIDString,
  elementIDStringCount,
  propertyString,
  propertyStringCount
) {
  const elementID = readString(elementIDString, elementIDStringCount)

  getElement(elementID)?.style.removeProperty(
    readString(propertyString, propertyStringCount)
  )
}

export function JavaScriptBridge_LinkElements(
  elementIDString,
  elementIDStringCount,
  parentIDString,
  parentIDStringCount
) {
  const elementID = readString(elementIDString, elementIDStringCount)
  const parentID = readString(parentIDString, parentIDStringCount)

  const element = getElement(elementID)
  const parentElement = getElement(parentID)
  parentElement.appendChild(element)
}

export function JavaScriptBridge_LinkElementsIfNeeded(
  elementIDString,
  elementIDStringCount,
  parentIDString,
  parentIDStringCount
) {
  const elementID = readString(elementIDString, elementIDStringCount)
  const parentID = readString(parentIDString, parentIDStringCount)

  const element = getElement(elementID)
  const parentElement = getElement(parentID)

  if (element.parentElement !== parentElement) {
    parentElement.appendChild(element)
  }
}

//export class UIFramework_JavaScriptBridge {
//  static updateElementText(id, text, textCount) {
//    this.getElement(id).textContent = this.readString(text, textCount)
//  }
//  static addEventListener(htmlEventType, id) {
//    const eventType = (() => {
//      switch (htmlEventType) {
//        case 1: return "click" // touchUpInside
//      }
//    })()
//
//    const eventHandler = () => {
//      this.instance.exports.UIJavaScriptBridge_HTMLElement_DispatchEvent(
//        id,
//        htmlEventType
//      )
//    }
//
//    if (!this.eventListeners.has(id)) {
//      this.eventListeners.set(id, new Map())
//    }
//    this.eventListeners.get(id).set(htmlEventType, eventHandler)
//
//    this.elements.get(id)?.addEventListener(eventType, eventHandler)
//  }
//}
