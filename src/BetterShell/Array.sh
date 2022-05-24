#!/usr/bin/env bash
# これらは互換性維持のための関数です
# 追加や削除は行わないでください

PrintArray(){ Array.Print "$@"; }
PrintEvalArray(){ Array.Eval "$1"; }
ArrayIndex(){ Array.Length "$1"; }
ArrayAppend(){ Array.Append "$1"; }
RevArray(){ Array.Rev "$1"; }
AddNewToArray(){ Array.Push "$@"; }
ArrayIncludes(){ Array.Includes "$@"; }
GetArrayIndex(){ Array.IndexOf "$1"; }
StrToCharList(){ Array.FromStr "$1"; }
