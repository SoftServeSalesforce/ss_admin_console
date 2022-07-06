public inherited sharing class SetConverter {

    public Object toSetOfType(FieldReference field, SObjectType sObjectType, Set<Object> objects) {
        Schema.SoapType fieldType = field.getFieldType(sObjectType);
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

    public Set<String> toSetOfString(Set<Object> so) {
        Set<String> ss = new Set<String>();
        for (Object o : so) {
            ss.add((String) o);
        }
        return ss;
    }

    public Set<Double> toSetOfDouble(Set<Object> so) {
        Set<Double> ss = new Set<Double>();
        for (Object o : so) {
            ss.add((Double) o);
        }
        return ss;
    }

    public Set<Integer> toSetOfInteger(Set<Object> so) {
        Set<Integer> ss = new Set<Integer>();
        for (Object o : so) {
            ss.add((Integer) o);
        }
        return ss;
    }

    public Set<Datetime> toSetOfDatetime(Set<Object> so) {
        Set<Datetime> ss = new Set<Datetime>();
        for (Object o : so) {
            ss.add((Datetime) o);
        }
        return ss;
    }

    public Set<Date> toSetOfDate(Set<Object> so) {
        Set<Date> ss = new Set<Date>();
        for (Object o : so) {
            ss.add((Date) o);
        }
        return ss;
    }

    public Set<Time> toSetOfTime(Set<Object> so) {
        Set<Time> ss = new Set<Time>();
        for (Object o : so) {
            ss.add((Time) o);
        }
        return ss;
    }

    public Set<Boolean> toSetOfBoolean(Set<Object> so) {
        Set<Boolean> ss = new Set<Boolean>();
        for (Object o : so) {
            ss.add((Boolean) o);
        }
        return ss;
    }
}
