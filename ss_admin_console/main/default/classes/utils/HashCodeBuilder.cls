public inherited sharing class HashCodeBuilder {
    private static final Integer DEFAULT_INITIAL_VALUE = 17;
    private static final Integer DEFAULT_MULTIPLIER_VALUE = 37;

    private final Integer iConstant;
    private Integer iTotal;

    public HashCodeBuilder() {
        iConstant = DEFAULT_MULTIPLIER_VALUE;
        iTotal = DEFAULT_INITIAL_VALUE;
    }

    public HashCodeBuilder(Integer initialOddNumber, Integer multiplierOddNumber) {
        if (Math.mod(initialOddNumber, 2) == 0) {
            throw new IllegalArgumentException('HashCodeBuilder requires an odd initial value');
        }
        if (Math.mod(multiplierOddNumber, 2) == 0) {
            throw new IllegalArgumentException('HashCodeBuilder requires an odd multiplier');
        }

        iConstant = multiplierOddNumber;
        iTotal = initialOddNumber;
    }

    public HashCodeBuilder append(final Boolean value) {
        iTotal = iTotal * iConstant + (value ? 0 : 1);
        return this;
    }

    public HashCodeBuilder append(Double value) {
        return append(((Object) value).hashCode());
    }

    public HashCodeBuilder append(Decimal value) {
        return append(((Object) value).hashCode());
    }

    public HashCodeBuilder append(Integer value) {
        iTotal = iTotal * iConstant + value;
        return this;
    }

    public HashCodeBuilder append(Long value) {
        append(((Object) value).hashCode());
        return this;
    }

    public HashCodeBuilder append(Id value) {
        append(((Object) value).hashCode());
        return this;
    }

    public HashCodeBuilder append(String value) {
        append(value.hashCode());
        return this;
    }

    public HashCodeBuilder append(Object obj) {
        if (obj == null) {
            iTotal = iTotal * iConstant;
        } else if (obj instanceof List<Object>) {
            append((List<Object>) obj);
        } else {
            iTotal = iTotal * iConstant + obj.hashCode();
        }
        return this;
    }

    public HashCodeBuilder append(Object[] objs) {
        if (objs == null) {
            iTotal = iTotal * iConstant;
        } else {
            for (Object obj : objs) {
                append(obj);
            }
        }
        return this;
    }

    public Integer toHashCode() {
        return iTotal;
    }

    public Integer build() {
        return toHashCode();
    }
}