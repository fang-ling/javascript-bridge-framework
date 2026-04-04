//
//  JavaScriptBridge.swift
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

import FoundationFramework

@_extern(wasm, module: "env", name: "JavaScriptBridge_InitializeElement")
public func JavaScriptBridge_InitializeElement(
  elementIDString: UnsafePointer<Integer32>,
  elementIDStringCount: UnsignedInteger64,
  elementType: UnsignedInteger32
)

@_extern(wasm, module: "env", name: "JavaScriptBridge_GetWindowWidth")
func JavaScriptBridge_GetWindowWidth() -> FloatingPoint64

@_extern(wasm, module: "env", name: "JavaScriptBridge_GetWindowHeight")
func JavaScriptBridge_GetWindowHeight() -> FloatingPoint64

@_extern(wasm, module: "env", name: "JavaScriptBridge_SetElementStyleProperty")
func JavaScriptBridge_SetElementStyleProperty(
  elementIDString: UnsafePointer<Integer32>,
  elementIDStringCount: UnsignedInteger64,
  propertyString: UnsafePointer<Integer32>,
  propertyStringCount: UnsignedInteger64,
  valueString: UnsafePointer<Integer32>,
  valueStringCount: UnsignedInteger64
)

@_extern(
  wasm,
  module: "env",
  name: "JavaScriptBridge_RemoveElementStyleProperty"
)
func JavaScriptBridge_RemoveElementStyleProperty(
  elementIDString: UnsafePointer<Integer32>,
  elementIDStringCount: UnsignedInteger64,
  propertyString: UnsafePointer<Integer32>,
  propertyStringCount: UnsignedInteger64
)

@_extern(wasm, module: "env", name: "JavaScriptBridge_LinkElements")
func JavaScriptBridge_LinkElements(
  elementIDString: UnsafePointer<Integer32>,
  elementIDStringCount: UnsignedInteger64,
  parentIDString: UnsafePointer<Integer32>,
  parentIDStringCount: UnsignedInteger64
)

@available(macOS 13.3.0, *)
public enum JavaScriptBridge {
  public static func initializeElement(
    elementID: UUID,
    elementType: ElementType
  ) {
    let elementIDString = elementID.uuidString

    JavaScriptBridge_InitializeElement(
      elementIDString: elementIDString.charactersView,
      elementIDStringCount: elementIDString.count,
      elementType: elementType.rawValue
    )
  }

  public static func getWindowWidth() -> FloatingPoint64 {
    JavaScriptBridge_GetWindowWidth()
  }

  public static func getWindowHeight() -> FloatingPoint64 {
    JavaScriptBridge_GetWindowHeight()
  }

  public static func setElementStyleProperty(
    elementID: UUID,
    property: String,
    value: String
  ) {
    let elementIDString = elementID.uuidString

    JavaScriptBridge_SetElementStyleProperty(
      elementIDString: elementIDString.charactersView,
      elementIDStringCount: elementIDString.count,
      propertyString: property.charactersView,
      propertyStringCount: property.count,
      valueString: value.charactersView,
      valueStringCount: value.count
    )
  }

  public static func removeElementStyleProperty(
    elementID: UUID,
    property: String
  ) {
    let elementIDString = elementID.uuidString

    JavaScriptBridge_RemoveElementStyleProperty(
      elementIDString: elementIDString.charactersView,
      elementIDStringCount: elementIDString.count,
      propertyString: property.charactersView,
      propertyStringCount: property.count,
    )
  }

  public static func linkElements(elementID: UUID, parentID: UUID?) {
    let elementIDString = elementID.uuidString
    let parentIDString = parentID?.uuidString ?? String("")

    JavaScriptBridge_LinkElements(
      elementIDString: elementIDString.charactersView,
      elementIDStringCount: elementIDString.count,
      parentIDString: parentIDString.charactersView,
      parentIDStringCount: parentIDString.count
    )
  }
}

@available(macOS 13.3.0, *)
extension JavaScriptBridge {
  public enum ElementType: UnsignedInteger32 {
    case division = 1
    case span = 2
    case button = 3
  }
}
