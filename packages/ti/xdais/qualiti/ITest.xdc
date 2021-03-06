/* 
 * Copyright (c) 2010, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */
metaonly interface ITest {

    enum TestStatus {
        TEST_NOTRUN,
        TEST_PASS,
        TEST_FAIL,
        TEST_NOTAPPLY,
        TEST_RUNNING,
        TEST_RUNERROR
    };

    enum TestDetailLevel {
        DETAILLEVEL_FAILDETAILS  = 0,
        DETAILLEVEL_TESTLOG      = 1,
        DETAILLEVEL_TESTOUTPUT   = 2
    };

    // this is defined in <TestModule>.xdc
    struct Test {
        string id;
        string title;
    };

    // this is returned by <TestModule>.getAttrs()
    struct TestAttrs {
        string description;
        bool   isPerformanceTest;
    };

    // this is returned by Compiler.getCompilerInfo, stored in AlgoParams
    struct CompilerParams {
        bool isTICompiler;
        bool isC6x;
        string libFormat;
        string version;
        string log;
    };

    // this is given to <TestModule>.run()
    struct AlgoParams {
        string moduleName;
        string vendor;
        string interfaceName;
        string architecture;
        string baseDir;
        string library;
        string headers[];
        CompilerParams compilerParams;
    };

    // this is given to <TestModule>.run()
    struct TestSettings {
        string cgtoolsDir;
        string cgxmlDir;
    };

    // this is returned by <TestModule>.run()
    struct TestResult {
        TestStatus       status;        // return code

        string           statusDetails; // elaborate description of what went
                                        // wrong (if it did, otherwise short)

        System.RunResult runResult;     // as-is return structure from test
                                        // command execution, needed only if
                                        // status is TEST_RUNERROR
    };

    // reset state of the test (usually an empty function)
    void reset( string testId );

    // returns basically test description
    TestAttrs getAttrs( string testId );

    // runs the test -- this is the real thing
    TestResult run( string testId, AlgoParams algoParams,
                    TestSettings testSettings,
                    int testDetailLevel, any cbPrintLog );
}

/*
 *  @(#) ti.xdais.qualiti; 1, 0, 0,108; 9-18-2010 14:46:37; /db/wtree/library/trees/dais/dais-t03x/src/ xlibrary

 */

