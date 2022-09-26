public class EqualsBuilder {
    private Boolean isEquals = true;

    public EqualsBuilder append(Object lhs, Object rhs) {
        if (!isEquals) {
            return this;
        }
        if (lhs == null && rhs == null) {
            return this;
        } else if (lhs != null) {
            this.isEquals = lhs.equals(rhs);
        } else {
            this.isEquals = false;
        }
        return this;
    }

    public EqualsBuilder append(List<Object> lhs, List<Object> rhs) {
        if (!isEquals) {
            return this;
        }
        if (isListEmpty(lhs) && isListEmpty(rhs)) {
            return this;
        } else if (!isListEmpty(lhs)) {
            this.isEquals = lhs.equals(rhs);
        } else {
            this.isEquals = false;
        }
        return this;
    }

    private static Boolean isListEmpty(List<Object> lst) {
        return lst == null || lst.isEmpty();
    }

    public Boolean build() {
        return isEquals;
    }
}