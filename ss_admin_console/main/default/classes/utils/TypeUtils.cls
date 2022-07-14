public inherited sharing class TypeUtils {
    public static Boolean isBatchable(String typeName) {
        return isBatchable(Type.forName(typeName));
    }

    public static Boolean isSchedulable(String typeName) {
        return isSchedulable(Type.forName(typeName));
    }

    public static Boolean isBatchable(Type theType) {
        return isInstanceOf(theType, Database.Batchable<SObject>.class);
    }

    public static Boolean isSchedulable(Type theType) {
        return isInstanceOf(theType, Schedulable.class);
    }

    public static Boolean isInstanceOf(Type child, Type parent) {
        return parent.isAssignableFrom(child);
    }
}