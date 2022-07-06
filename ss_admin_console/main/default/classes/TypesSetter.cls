public with sharing class TypesSetter {

    public Object toSetOfType(FieldReference field, String sObjectType, Set<Object> objects){
        String fieldType = field.getFieldType(sObjectType);
        if (fieldType == 'String' || fieldType == 'Email') {
            return toSetOfString(objects);
        } else if (fieldType == 'Decimal') {
            return toSetOfDecimal(objects);
        } else if (fieldType == 'Double') {
            return toSetOfDouble(objects);
        } else if (fieldType == 'Integer') {
            return toSetOfInteger(objects); 
        } else if (fieldType == 'Datetime') {
            return toSetOfDatetime(objects);
        } else if (fieldType == 'Date') {
            return toSetOfDate(objects);
        } else if (fieldType == 'Time') {
            return toSetOfTime(objects);
        }  
        return null;
    }


    public Set<String> toSetOfString(Set<Object> so) {
        Set<String> ss = new Set<String>();
        for (Object o : so) {
            ss.add((String) o);
        }
        return ss;
    }

    public Set<Decimal> toSetOfDecimal(Set<Object> so) {
        Set<Decimal> ss = new Set<Decimal>();
        for (Object o : so) {
            ss.add((Decimal) o);
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
}
