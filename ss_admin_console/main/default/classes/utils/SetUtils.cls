/**
* Converts Set of Objects to Set of  elements of certain data type.
*/
public inherited sharing class SetUtils {

    /**
     * Determines type of field that is represented by the FieldReference and
     * converts Set of Objects to Set of elements of determined type.
     * @param field describes FieldReference to a field of SObject
     * @return set of elements of certain type
     */
    public static Object toSetOfType(FieldReference field, Set<Object> objects) {
        Schema.SoapType fieldType = field.getField().getDescribe().getSoapType();
        if (fieldType == Schema.SoapType.DOUBLE) {
            return toSetOfDouble(objects);
        } else if (fieldType == Schema.SoapType.INTEGER) {
            return toSetOfInteger(objects); 
        } else if (fieldType == Schema.SoapType.DATETIME) {
            return toSetOfDatetime(objects);
        } else if (fieldType == Schema.SoapType.DATE) {
            return toSetOfDate(objects);
        } else if (fieldType == Schema.SoapType.TIME) {
            return toSetOfTime(objects);
        } else if (fieldType == Schema.SoapType.BOOLEAN) {
            return toSetOfBoolean(objects);
        } else {
            return toSetOfString(objects);
        }
    }

    /**
     * Converts Set<Object> to Set<String>.
     * @param so contains objects to be converted
     * @return set containing converted objects to strings
     */
    public static Set<String> toSetOfString(Set<Object> so) {
        Set<String> ss = new Set<String>();
        for (Object o : so) {
            ss.add((String) o);
        }
        return ss;
    }

    /**
     * Converts Set<Object> to Set<Double>.
     * @param so contains objects to be converted
     * @return set containing converted objects to doubles
     */
    public static Set<Double> toSetOfDouble(Set<Object> so) {
        Set<Double> ss = new Set<Double>();
        for (Object o : so) {
            ss.add((Double) o);
        }
        return ss;
    }

    /**
     * Converts Set<Object> to Set<Integer>.
     * @param so contains objects to be converted
     * @return set containing converted objects to integers
     */
    public static Set<Integer> toSetOfInteger(Set<Object> so) {
        Set<Integer> ss = new Set<Integer>();
        for (Object o : so) {
            ss.add((Integer) o);
        }
        return ss;
    }

    /**
     * Converts Set<Object> to Set<Datetime>.
     * @param so contains objects to be converted
     * @return set containing converted objects to datetimes
     */
    public static Set<Datetime> toSetOfDatetime(Set<Object> so) {
        Set<Datetime> ss = new Set<Datetime>();
        for (Object o : so) {
            ss.add((Datetime) o);
        }
        return ss;
    }

    /**
     * Converts Set<Object> to Set<Date>.
     * @param so contains objects to be converted
     * @return set containing converted objects to dates
     */
    public static Set<Date> toSetOfDate(Set<Object> so) {
        Set<Date> ss = new Set<Date>();
        for (Object o : so) {
            ss.add((Date) o);
        }
        return ss;
    }

    /**
     * Converts Set<Object> to Set<Time>.
     * @param so contains objects to be converted
     * @return set containing converted objects to times
     */
    public static Set<Time> toSetOfTime(Set<Object> so) {
        Set<Time> ss = new Set<Time>();
        for (Object o : so) {
            ss.add((Time) o);
        }
        return ss;
    }

    /**
     * Converts Set<Object> to Set<Boolean>.
     * @param so contains objects to be converted
     * @return set containing converted objects to booleans
     */
    public static Set<Boolean> toSetOfBoolean(Set<Object> so) {
        Set<Boolean> ss = new Set<Boolean>();
        for (Object o : so) {
            ss.add((Boolean) o);
        }
        return ss;
    }
}
