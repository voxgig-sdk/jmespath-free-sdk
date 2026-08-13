# JmespathFree SDK utility: make_context

from projectname_sdk.core.context import JmespathFreeContext


def make_context_util(ctxmap, basectx):
    return JmespathFreeContext(ctxmap, basectx)
