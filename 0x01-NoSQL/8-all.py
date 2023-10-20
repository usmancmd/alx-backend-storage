#!/usr/bin/env python3
"""lists all documents in a collection"""


def list_all(mongo_collection):
    """lists all documents in a collection"""
    if mongo_collection == {}:
        return []
    documents = mongo_collection.find()
    return list(documents)
