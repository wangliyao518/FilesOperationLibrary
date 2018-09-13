# -*- coding: utf-8 -*-
"""
:created on: 2018/8/28

:copyright:
:author: leo
:contact:
"""
from .exception import AliasError, NameIsProtected


class Store(object):
    """Class to build object needed to add/remove/show/protect objects.

    .. code-block:: python

        store = Store()                          # Create new store

        store.add("Some object")                 # Adds object under "default" alias
        store.add("Some object", alias='test')   # Adds object under "test" alias

        store.get()                              # Returns object represented by "default" alias
        store.get(alias='test')                  # Returns object represented by "test" alias

        store.remove()                           # Removes object represented by "default" alias
        store.remove(alias='test')               # Removes object represented by "test" alias

        store.has_alias()                        # Checks if default alias was added
        store.has_alias(alias='test')            # Checks is "test" alias was added

        aliases = store.aliases                  # Returns list of available aliases
    """

    def __init__(self):
        self._objects = {}

    def __iter__(self):
        return (each for each in self._objects.values())

    @property
    def aliases(self):
        """Property to get all available aliases.

        :return: List of available aliases.
        :rtype: list
        """
        return list(self._objects.keys())

    def add(self, value, alias=None):
        """Add new object to store and protect it to be not overridden.

        :param value:         Some object to store.
        :param string alias:  Alias (reference) for stored object.
                              Alias "default" is reserved and is used when alias is not specified.
        """
        alias = self._get_alias(alias)
        if alias in self._objects:
            raise NameIsProtected("Alias ({}) exists. Please remove it to reuse.".format(alias))
        self._objects[alias] = value

    def remove(self, alias=None):
        """Remove object stored under specified name.

        :param string alias: Alias (reference) for stored object.
                             Alias "default" is reserved and is used when alias is not specified.
        """
        alias = self._get_alias(alias)
        if alias not in self._objects:
            raise AliasError("Provided alias ({}) doesn't exist. "
                             "Please setup library before any other operation.".format(alias))
        del self._objects[alias]

    def get(self, alias=None):
        """Returns object specified by the name.

        :param string alias: Alias (reference) for stored object.
                             Alias "default" is reserved and is used when alias is not specified.

        :return: Object represented by specified alias or represented by "default" alias
        """
        alias = self._get_alias(alias)
        if alias not in self._objects:
            raise AliasError("Provided alias ({}) doesn't exist. "
                             "Please setup library before any other operation.".format(alias))
        return self._objects[alias]

    def has_alias(self, alias=None):
        """Check if provided alias exists.

        :param string alias: Alias (reference) for stored object.
                             Alias "default" is reserved and is used when alias is not specified.

        :return: Operation result.
        :rtype: boolean
        """
        alias = self._get_alias(alias)
        return alias in self._objects

    def _get_alias(self, alias):
        return "default" if alias is None else alias
