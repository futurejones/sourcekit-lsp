//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import LanguageServerProtocol
import SKCore
import SKSupport
import SemanticIndex

import struct TSCBasic.AbsolutePath
import struct TSCBasic.RelativePath

extension SourceKitLSPServer {
  /// Configuration options for the SourceKitServer.
  public struct Options: Sendable {
    /// Additional compiler flags (e.g. `-Xswiftc` for SwiftPM projects) and other build-related
    /// configuration.
    public var buildSetup: BuildSetup

    /// Additional arguments to pass to `clangd` on the command-line.
    public var clangdOptions: [String]

    /// Additional paths to search for a compilation database, relative to a workspace root.
    public var compilationDatabaseSearchPaths: [RelativePath]

    /// Additional options for the index.
    public var indexOptions: IndexOptions

    /// Options for code-completion.
    public var completionOptions: SKCompletionOptions

    /// Override the default directory where generated interfaces will be stored
    public var generatedInterfacesPath: AbsolutePath

    /// The time that `SwiftLanguageService` should wait after an edit before starting to compute diagnostics and
    /// sending a `PublishDiagnosticsNotification`.
    ///
    /// This is mostly intended for testing purposes so we don't need to wait the debouncing time to get a diagnostics
    /// notification when running unit tests.
    public var swiftPublishDiagnosticsDebounceDuration: TimeInterval

    /// When a task is started that should be displayed to the client as a work done progress, how many milliseconds to
    /// wait before actually starting the work done progress. This prevents flickering of the work done progress in the
    /// client for short-lived index tasks which end within this duration.
    public var workDoneProgressDebounceDuration: Duration

    /// Experimental features that are enabled.
    public var experimentalFeatures: Set<ExperimentalFeature>

    public var indexTestHooks: IndexTestHooks

    public init(
      buildSetup: BuildSetup = .default,
      clangdOptions: [String] = [],
      compilationDatabaseSearchPaths: [RelativePath] = [],
      indexOptions: IndexOptions = .init(),
      completionOptions: SKCompletionOptions = .init(),
      generatedInterfacesPath: AbsolutePath = defaultDirectoryForGeneratedInterfaces,
      swiftPublishDiagnosticsDebounceDuration: TimeInterval = 2, /* 2s */
      workDoneProgressDebounceDuration: Duration = .seconds(0),
      experimentalFeatures: Set<ExperimentalFeature> = [],
      indexTestHooks: IndexTestHooks = IndexTestHooks()
    ) {
      self.buildSetup = buildSetup
      self.clangdOptions = clangdOptions
      self.compilationDatabaseSearchPaths = compilationDatabaseSearchPaths
      self.indexOptions = indexOptions
      self.completionOptions = completionOptions
      self.generatedInterfacesPath = generatedInterfacesPath
      self.swiftPublishDiagnosticsDebounceDuration = swiftPublishDiagnosticsDebounceDuration
      self.experimentalFeatures = experimentalFeatures
      self.workDoneProgressDebounceDuration = workDoneProgressDebounceDuration
      self.indexTestHooks = indexTestHooks
    }
  }
}
